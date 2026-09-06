import 'package:flutter/material.dart';
import 'package:studylens_ai/models/sudy_result.dart';
import 'package:studylens_ai/theme/app_theme.dart'; 
import 'package:studylens_ai/widgets/primery_button.dart'; 
import '../widgets/concept_card.dart'; 
import '../widgets/section_card.dart';
import 'quiz_screen.dart';

/// Displays the AI-generated study material: summary, key concepts,
/// a simplified explanation, and an entry point into the quiz.
class StudyResultScreen extends StatelessWidget {
  final StudyResult studyResult;

  const StudyResultScreen({super.key, required this.studyResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Study Material')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            SectionCard(
              title: 'Summary',
              icon: Icons.summarize_rounded,
              child: Text(
                studyResult.summary,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SectionCard(
              title: 'Key Concepts',
              icon: Icons.lightbulb_outline_rounded,
              child: Column(
                children: [
                  for (int i = 0; i < studyResult.keyConcepts.length; i++)
                    ConceptCard(
                      index: i + 1,
                      concept: studyResult.keyConcepts[i],
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SectionCard(
              title: 'Simple Explanation',
              icon: Icons.chat_bubble_outline_rounded,
              child: Text(
                studyResult.simpleExplanation,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SectionCard(
              title: 'Quiz',
              icon: Icons.quiz_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${studyResult.quizQuestions.length} questions generated '
                    'from your study material.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  PrimaryButton(
                    label: 'Start Quiz',
                    icon: Icons.play_arrow_rounded,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => QuizScreen(
                            questions: studyResult.quizQuestions,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}