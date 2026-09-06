import 'package:studylens_ai/models/sudy_result.dart';

import '../models/quiz_question.dart'; 
import 'ai_study_service.dart';

/// A fake implementation of [AiStudyService] used for building and testing
/// the app before a real AI backend is connected. It ignores the actual
/// content of [inputText] (beyond using it for a light touch of realism)
/// and always returns the same well-formed sample [StudyResult].
class MockAiStudyService implements AiStudyService {
  @override
  Future<StudyResult> generateStudyMaterial(String inputText) async {
    // Simulate network / processing delay so the loading UI can be tested.
    await Future.delayed(const Duration(seconds: 2));

    return const StudyResult(
      summary:
          'This material introduces the core idea that systems are made up '
          'of smaller interacting parts, and that understanding how those '
          'parts connect is often more useful than memorizing isolated '
          'facts. The text walks through the main definitions, gives a '
          'few real-world examples, and highlights why the topic matters '
          'in practice.',
      keyConcepts: [
        'Definition: a clear, precise statement of what the core term means.',
        'Components: the smaller building blocks that make up the topic.',
        'Relationships: how the components interact with or depend on one another.',
        'Real-world example: a practical situation where this concept applies.',
        'Common misconception: a mistake learners often make when first studying this.',
      ],
      simpleExplanation:
          'Think of it like a team working on a group project. Each person '
          '(component) has a specific job, and the project only succeeds '
          'if everyone communicates and works together (relationships). '
          'If one person misunderstands their role, the whole project can '
          'be affected. This topic is really about understanding both the '
          'individual pieces and how they fit together as a whole.',
      quizQuestions: [
        QuizQuestion(
          question: 'What is the main focus of the study material?',
          options: [
            'Memorizing isolated facts',
            'Understanding how parts of a system connect',
            'Learning historical dates',
            'Practicing handwriting',
          ],
          correctAnswer: 'Understanding how parts of a system connect',
          explanation:
              'The material emphasizes relationships between components '
              'over rote memorization of isolated facts.',
        ),
        QuizQuestion(
          question: 'In the group project analogy, what do "components" represent?',
          options: [
            'The deadline for the project',
            'The final grade',
            'Each team member and their individual role',
            'The classroom the team works in',
          ],
          correctAnswer: 'Each team member and their individual role',
          explanation:
              'Each team member stands in for a component of the system, '
              'each with a distinct responsibility.',
        ),
        QuizQuestion(
          question: 'Why can a misunderstanding by one component affect the whole system?',
          options: [
            'Because components never interact',
            'Because systems rely on components working together',
            'Because it does not affect the system at all',
            'Because only the largest component matters',
          ],
          correctAnswer: 'Because systems rely on components working together',
          explanation:
              'Since components depend on and interact with each other, '
              'a problem in one part can ripple through the system.',
        ),
        QuizQuestion(
          question: 'What is a "common misconception" mentioned in the key concepts?',
          options: [
            'A guaranteed fact about the topic',
            'A mistake learners often make when first studying the topic',
            'The official definition of the topic',
            'A quiz question format',
          ],
          correctAnswer: 'A mistake learners often make when first studying the topic',
          explanation:
              'Common misconceptions highlight where learners typically go '
              'wrong so they can be avoided.',
        ),
        QuizQuestion(
          question: 'Which of these best matches the "simple explanation" style?',
          options: [
            'A dense technical definition with no examples',
            'A relatable analogy connecting the concept to everyday life',
            'A list of unrelated trivia',
            'A set of raw statistics only',
          ],
          correctAnswer: 'A relatable analogy connecting the concept to everyday life',
          explanation:
              'Simple explanations use familiar analogies, like the group '
              'project example, to make abstract ideas easier to grasp.',
        ),
      ],
    );
  }
}