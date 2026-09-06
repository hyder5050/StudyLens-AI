import 'quiz_question.dart';

/// Holds everything generated from the user's study material:
/// a summary, key concepts, a simplified explanation, and quiz questions.
class StudyResult {
  final String summary;
  final List<String> keyConcepts;
  final String simpleExplanation;
  final List<QuizQuestion> quizQuestions;

  const StudyResult({
    required this.summary,
    required this.keyConcepts,
    required this.simpleExplanation,
    required this.quizQuestions,
  });

  /// Builds a [StudyResult] from a decoded JSON map (the structure the
  /// AI is asked to return), validating that every required field is
  /// present, non-empty, and well-formed.
  ///
  /// Throws a [FormatException] with a human-readable message describing
  /// exactly what was missing or invalid, so callers can surface a
  /// friendly error to the user.
  factory StudyResult.fromJson(Map<String, dynamic> json) {
    final summary = json['summary'];
    if (summary is! String || summary.trim().isEmpty) {
      throw const FormatException('the summary is missing');
    }

    final rawKeyConcepts = json['keyConcepts'];
    if (rawKeyConcepts is! List || rawKeyConcepts.isEmpty) {
      throw const FormatException('no key concepts were returned');
    }
    final keyConcepts =
        rawKeyConcepts.map((concept) => concept.toString()).toList();

    final simpleExplanation = json['simpleExplanation'];
    if (simpleExplanation is! String || simpleExplanation.trim().isEmpty) {
      throw const FormatException('the simple explanation is missing');
    }

    final rawQuizQuestions = json['quizQuestions'];
    if (rawQuizQuestions is! List || rawQuizQuestions.isEmpty) {
      throw const FormatException('no quiz questions were returned');
    }

    // Parse each question defensively: a single malformed question
    // (e.g. missing a field) shouldn't sink the whole result as long as
    // at least one valid question comes through.
    final quizQuestions = <QuizQuestion>[];
    for (final item in rawQuizQuestions) {
      if (item is! Map) continue;
      try {
        quizQuestions.add(QuizQuestion.fromJson(Map<String, dynamic>.from(item)));
      } on FormatException {
        continue;
      }
    }
    if (quizQuestions.isEmpty) {
      throw const FormatException('no valid quiz questions were returned');
    }

    return StudyResult(
      summary: summary,
      keyConcepts: keyConcepts,
      simpleExplanation: simpleExplanation,
      quizQuestions: quizQuestions,
    );
  }
}
