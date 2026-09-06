import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  ApiConfig._();

  static const bool useMockService = false;

  static String get apiKey =>
      dotenv.env['GEMINI_API_KEY'] ?? '';

  static const String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent';

  static const String model = 'gemini-3.5-flash';

  static const Duration requestTimeout =
      Duration(seconds: 45);
}