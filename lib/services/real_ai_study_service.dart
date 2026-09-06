 import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/sudy_result.dart';
import 'ai_study_service.dart';

/// Exception thrown when the AI study service cannot generate
/// valid study material.
class AiServiceException implements Exception {
  final String message;

  const AiServiceException(this.message);

  @override
  String toString() => message;
}

/// Real Gemini-powered implementation of [AiStudyService].
///
/// This service:
/// - validates user input
/// - sends study material to Gemini
/// - handles network/API errors
/// - extracts JSON safely
/// - converts the response into [StudyResult]
class RealAiStudyService implements AiStudyService {
  final http.Client _client;
  final bool _ownsClient;

  RealAiStudyService({http.Client? client})
      : _client = client ?? http.Client(),
        _ownsClient = client == null;

  /// Maximum amount of text accepted from the user.
  ///
  /// This protects the app from accidentally sending extremely large
  /// requests to the AI API.
  static const int maxInputLength = 30000;

  @override
  Future<StudyResult> generateStudyMaterial(String inputText) async {
    final trimmedInput = inputText.trim();

    _validateInput(trimmedInput);

    final response = await _sendRequest(trimmedInput);

    final decodedResponse = _decodeResponse(response.body);

    final rawText = _extractText(decodedResponse);

    if (rawText.isEmpty) {
      throw const AiServiceException(
        'Gemini did not return any content. Please try again.',
      );
    }

    final studyJson = _extractJsonObject(rawText);

    try {
      return StudyResult.fromJson(studyJson);
    } on FormatException catch (e) {
      throw AiServiceException(
        'The Gemini response was missing expected data (${e.message}). '
        'Please try again.',
      );
    } catch (_) {
      throw const AiServiceException(
        'Gemini returned study material in an unexpected format. '
        'Please try again.',
      );
    }
  }

  /// Validates user input and API configuration.
  void _validateInput(String input) {
    if (input.isEmpty) {
      throw const AiServiceException(
        'Please provide some study material before generating.',
      );
    }

    if (input.length > maxInputLength) {
      throw const AiServiceException(
        'Study material is too long. Please provide a shorter section.',
      );
    }

    if (ApiConfig.apiKey.trim().isEmpty) {
      throw const AiServiceException(
        'No Gemini API key is configured. '
        'Add GEMINI_API_KEY to your .env file and restart the app.',
      );
    }
  }

  /// Sends the request to Gemini.
  Future<http.Response> _sendRequest(String input) async {
    final url = Uri.parse(
      '${ApiConfig.apiUrl}?key=${Uri.encodeQueryComponent(ApiConfig.apiKey)}',
    );

    try {
      final response = await _client
          .post(
            url,
            headers: const {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'contents': [
                {
                  'parts': [
                    {
                      'text': '''
$_systemPrompt

Study material:
"""
$input
"""
''',
                    },
                  ],
                },
              ],
              'generationConfig': {
                'temperature': 0.2,
                'responseMimeType': 'application/json',
              },
            }),
          )
          .timeout(ApiConfig.requestTimeout);

      if (response.statusCode != 200) {
        throw AiServiceException(
          _friendlyApiError(
            response.statusCode,
            response.body,
          ),
        );
      }

      return response;
    } on AiServiceException {
      rethrow;
    } on TimeoutException {
      throw const AiServiceException(
        'The request took too long to respond. '
        'Please check your internet connection and try again.',
      );
    } on http.ClientException {
      throw const AiServiceException(
        'Could not reach Gemini. '
        'Please check your internet connection and try again.',
      );
    } catch (_) {
      throw const AiServiceException(
        'A network error occurred. Please try again.',
      );
    }
  }

  /// Converts Gemini's response body into a JSON map.
  Map<String, dynamic> _decodeResponse(String body) {
    try {
      final decoded = jsonDecode(body);

      if (decoded is! Map<String, dynamic>) {
        throw const AiServiceException(
          'Gemini returned an unexpected response format.',
        );
      }

      return decoded;
    } on AiServiceException {
      rethrow;
    } on FormatException {
      throw const AiServiceException(
        'Gemini returned an unreadable response. Please try again.',
      );
    } catch (_) {
      throw const AiServiceException(
        'Gemini returned an invalid response. Please try again.',
      );
    }
  }

  /// Extracts text from Gemini's candidates.
  ///
  /// Multiple text parts are supported instead of assuming that
  /// the first part always contains the complete response.
  String _extractText(Map<String, dynamic> decoded) {
    try {
      final candidates = decoded['candidates'];

      if (candidates is! List || candidates.isEmpty) {
        return '';
      }

      for (final candidate in candidates) {
        if (candidate is! Map<String, dynamic>) {
          continue;
        }

        final content = candidate['content'];

        if (content is! Map<String, dynamic>) {
          continue;
        }

        final parts = content['parts'];

        if (parts is! List) {
          continue;
        }

        final textParts = <String>[];

        for (final part in parts) {
          if (part is Map<String, dynamic>) {
            final text = part['text'];

            if (text is String && text.trim().isNotEmpty) {
              textParts.add(text.trim());
            }
          }
        }

        if (textParts.isNotEmpty) {
          return textParts.join('\n').trim();
        }
      }

      return '';
    } catch (_) {
      return '';
    }
  }

  /// Extracts a JSON object from Gemini's response.
  ///
  /// Handles:
  /// - plain JSON
  /// - ```json ... ```
  /// - JSON surrounded by accidental text
  Map<String, dynamic> _extractJsonObject(String text) {
    var candidate = text.trim();

    // Remove Markdown code fences if Gemini accidentally adds them.
    if (candidate.startsWith('```')) {
      candidate = candidate.replaceFirst(
        RegExp(r'^```[a-zA-Z]*\s*'),
        '',
      );

      candidate = candidate.replaceFirst(
        RegExp(r'```\s*$'),
        '',
      );

      candidate = candidate.trim();
    }

    final start = candidate.indexOf('{');
    final end = candidate.lastIndexOf('}');

    if (start == -1 || end == -1 || end < start) {
      throw const AiServiceException(
        'Gemini response was not in the expected JSON format.',
      );
    }

    candidate = candidate.substring(start, end + 1);

    dynamic parsed;

    try {
      parsed = jsonDecode(candidate);
    } on FormatException {
      throw const AiServiceException(
        'Gemini response contained invalid JSON. Please try again.',
      );
    }

    if (parsed is! Map<String, dynamic>) {
      throw const AiServiceException(
        'Gemini response JSON was not structured as expected.',
      );
    }

    return parsed;
  }

  /// Converts HTTP status codes into student-friendly error messages.
  String _friendlyApiError(
    int statusCode,
    String responseBody,
  ) {
    switch (statusCode) {
      case 400:
        return 'Gemini rejected the request. '
            'Please check your study text and API configuration.';

      case 401:
      case 403:
        return 'The Gemini API key is invalid or does not have '
            'permission to use the API.';

      case 429:
        return 'Gemini rate limit reached. '
            'Please wait a moment and try again.';

      case 500:
      case 502:
      case 503:
        return 'Gemini is temporarily unavailable. '
            'Please try again shortly.';

      default:
        return 'Gemini returned an error (status $statusCode).';
    }
  }

  /// Closes the HTTP client when this service owns it.
  ///
  /// If a client was injected from outside, its lifecycle remains
  /// the responsibility of the caller.
  void dispose() {
    if (_ownsClient) {
      _client.close();
    }
  }

  static const String _systemPrompt = '''
You are an academic study assistant embedded in the "AI Study Helper" app.

Your ONLY job is to transform the study material the user provides into
structured study aids and return them as JSON.

STRICT RULES:
- Use ONLY the study material provided by the user as your source of truth.
- Do not invent facts, examples, or topics.
- Do not add unrelated information or filler.
- Return valid JSON only.
- Do not use Markdown.
- Do not wrap the JSON in code fences.

Return exactly this structure:

{
  "summary": "A concise summary of the study material (3-5 sentences).",
  "keyConcepts": [
    "Concept 1",
    "Concept 2",
    "Concept 3"
  ],
  "simpleExplanation": "A simple student-friendly explanation.",
  "quizQuestions": [
    {
      "question": "Question text",
      "options": [
        "Option A",
        "Option B",
        "Option C",
        "Option D"
      ],
      "correctAnswer": "Option B",
      "explanation": "Why this answer is correct."
    }
  ]
}

REQUIREMENTS:
- keyConcepts: 3 to 7 important concepts.
- quizQuestions: approximately 5 questions.
- Every question must have exactly 4 options.
- correctAnswer must exactly match one option.
- Use simple language suitable for students.
- Questions must be based only on the supplied study material.
- Explanations must be based only on the supplied study material.
''';
} 