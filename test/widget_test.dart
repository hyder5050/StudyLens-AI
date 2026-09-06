// Basic smoke test: verifies the app builds and shows the Home screen.
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:studylens_ai/main.dart';
import 'package:studylens_ai/services/real_ai_study_service.dart';

void main() {
  testWidgets('Home screen shows title and Start Studying button',
      (WidgetTester tester) async {
    await tester.pumpWidget(AistudyLensApp());

    expect(find.text('AI Study Helper'), findsOneWidget);
    expect(find.text('Start Studying'), findsOneWidget);
  });

  test('Real AI parser converts valid JSON into StudyResult', () {
    final jsonText = jsonEncode({
      'summary': 'A concise summary.',
      'keyConcepts': ['One', 'Two'],
      'simpleExplanation': 'Simple explanation.',
      'quizQuestions': [
        {
          'question': 'Which is correct?',
          'options': ['A', 'B', 'C', 'D'],
          'correctAnswer': 'B',
          'explanation': 'Because B is the right answer.',
        }
      ],
    });

    final result = RealAiStudyService.parseStudyResult(jsonText);

    expect(result.summary, 'A concise summary.');
    expect(result.keyConcepts, ['One', 'Two']);
    expect(result.quizQuestions.length, 1);
    expect(result.quizQuestions.first.correctAnswer, 'B');
  });
}
