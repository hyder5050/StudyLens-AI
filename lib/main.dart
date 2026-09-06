
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables.
  //
  // If .env is missing, the app will still start.
  // The AI service will show a friendly configuration error
  // when the user tries to generate study material.
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('Warning: .env file could not be loaded.');
  }

  runApp(const AiStudyHelperApp());
}

class AiStudyHelperApp extends StatelessWidget {
  const AiStudyHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Study Helper',
      debugShowCheckedModeBanner: false,

      // Centralized application theme.
      theme: AppTheme.lightTheme,

      // First screen shown when the app starts.
      home: const HomeScreen(),
    );
  }
} 