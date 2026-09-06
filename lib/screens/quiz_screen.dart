// import 'package:flutter/material.dart';
// import 'package:studylens_ai/theme/app_theme.dart'; 
// import 'package:studylens_ai/widgets/primery_button.dart';
// import '../models/quiz_question.dart'; 
// import '../widgets/quiz_option.dart';

// /// Runs the quiz one question at a time, then shows a final score screen.
// class QuizScreen extends StatefulWidget {
//   final List<QuizQuestion> questions;

//   const QuizScreen({super.key, required this.questions});

//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   int _currentIndex = 0;
//   int _correctCount = 0;
//   String? _selectedOption;
//   bool _hasAnswered = false;
//   bool _isFinished = false;

//   QuizQuestion get _currentQuestion => widget.questions[_currentIndex];

//   void _selectOption(String option) {
//     if (_hasAnswered) return;

//     setState(() {
//       _selectedOption = option;
//       _hasAnswered = true;
//       if (option == _currentQuestion.correctAnswer) {
//         _correctCount++;
//       }
//     });
//   }

//   void _goToNext() {
//     final isLastQuestion = _currentIndex == widget.questions.length - 1;

//     if (isLastQuestion) {
//       setState(() => _isFinished = true);
//       return;
//     }

//     setState(() {
//       _currentIndex++;
//       _selectedOption = null;
//       _hasAnswered = false;
//     });
//   }

//   void _restartQuiz() {
//     setState(() {
//       _currentIndex = 0;
//       _correctCount = 0;
//       _selectedOption = null;
//       _hasAnswered = false;
//       _isFinished = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Quiz')),
//       body: SafeArea(
//         child: _isFinished ? _buildScoreView(context) : _buildQuestionView(context),
//       ),
//     );
//   }

//   Widget _buildQuestionView(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final colorScheme = Theme.of(context).colorScheme;
//     final totalQuestions = widget.questions.length;

//     return Padding(
//       padding: const EdgeInsets.all(AppSpacing.md),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: LinearProgressIndicator(
//               value: (_currentIndex + 1) / totalQuestions,
//               minHeight: 8,
//               backgroundColor: colorScheme.surfaceContainerHighest,
//             ),
//           ),
//           const SizedBox(height: AppSpacing.sm),
//           Text(
//             'Question ${_currentIndex + 1} of $totalQuestions',
//             style: textTheme.bodyMedium?.copyWith(
//               color: colorScheme.onSurfaceVariant,
//             ),
//           ),
//           const SizedBox(height: AppSpacing.md),
//           Text(
//             _currentQuestion.question,
//             style: textTheme.titleLarge,
//           ),
//           const SizedBox(height: AppSpacing.lg),
//           Expanded(
//             child: ListView(
//               children: [
//                 for (final option in _currentQuestion.options)
//                   QuizOption(
//                     optionText: option,
//                     isSelected: _selectedOption == option,
//                     isCorrectAnswer: option == _currentQuestion.correctAnswer,
//                     hasAnswered: _hasAnswered,
//                     onTap: () => _selectOption(option),
//                   ),
//                 if (_hasAnswered) ...[
//                   const SizedBox(height: AppSpacing.sm),
//                   Container(
//                     padding: const EdgeInsets.all(AppSpacing.md),
//                     decoration: BoxDecoration(
//                       color: colorScheme.surfaceContainerLow,
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Icon(Icons.info_outline,
//                             size: 20, color: colorScheme.primary),
//                         const SizedBox(width: AppSpacing.sm),
//                         Expanded(
//                           child: Text(
//                             _currentQuestion.explanation,
//                             style: textTheme.bodyMedium,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//           const SizedBox(height: AppSpacing.md),
//           PrimaryButton(
//             label: _currentIndex == totalQuestions - 1 ? 'Finish' : 'Next',
//             onPressed: _hasAnswered ? _goToNext : null,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildScoreView(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final colorScheme = Theme.of(context).colorScheme;
//     final total = widget.questions.length;
//     final incorrectCount = total - _correctCount;
//     final percentage = total == 0 ? 0 : ((_correctCount / total) * 100).round();

//     final String resultMessage;
//     if (percentage >= 80) {
//       resultMessage = 'Excellent work! You know this material well.';
//     } else if (percentage >= 50) {
//       resultMessage = 'Good effort! A little more review will help.';
//     } else {
//       resultMessage = 'Keep studying — review the material and try again.';
//     }

//     return Padding(
//       padding: const EdgeInsets.all(AppSpacing.lg),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.emoji_events_rounded,
//             size: 72,
//             color: colorScheme.primary,
//           ),
//           const SizedBox(height: AppSpacing.lg),
//           Text(
//             '$percentage%',
//             style: textTheme.headlineMedium,
//           ),
//           const SizedBox(height: AppSpacing.sm),
//           Text(
//             resultMessage,
//             style: textTheme.bodyLarge,
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: AppSpacing.lg),
//           Row(
//             children: [
//               Expanded(
//                 child: _ScoreStat(
//                   label: 'Correct',
//                   value: '$_correctCount',
//                   color: Colors.green,
//                 ),
//               ),
//               const SizedBox(width: AppSpacing.md),
//               Expanded(
//                 child: _ScoreStat(
//                   label: 'Incorrect',
//                   value: '$incorrectCount',
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: AppSpacing.xl),
//           PrimaryButton(
//             label: 'Restart Quiz',
//             icon: Icons.refresh_rounded,
//             onPressed: _restartQuiz,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ScoreStat extends StatelessWidget {
//   final String label;
//   final String value;
//   final Color color;

//   const _ScoreStat({
//     required this.label,
//     required this.value,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         vertical: AppSpacing.md,
//         horizontal: AppSpacing.sm,
//       ),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Column(
//         children: [
//           Text(
//             value,
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineMedium
//                 ?.copyWith(color: color),
//           ),
//           const SizedBox(height: 4),
//           Text(label, style: Theme.of(context).textTheme.bodyMedium),
//         ],
//       ),
//     );
//   }
// }
 
import 'package:flutter/material.dart';
import 'package:studylens_ai/theme/app_theme.dart';
import 'package:studylens_ai/widgets/primery_button.dart';

import '../models/quiz_question.dart';
import '../widgets/quiz_option.dart';

/// Runs the quiz one question at a time, then shows a final score screen.
class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> questions;

  const QuizScreen({
    super.key,
    required this.questions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _correctCount = 0;
  String? _selectedOption;
  bool _hasAnswered = false;
  bool _isFinished = false;

  QuizQuestion get _currentQuestion => widget.questions[_currentIndex];

  void _selectOption(String option) {
    if (_hasAnswered) return;

    setState(() {
      _selectedOption = option;
      _hasAnswered = true;

      if (option == _currentQuestion.correctAnswer) {
        _correctCount++;
      }
    });
  }

  void _goToNext() {
    final isLastQuestion =
        _currentIndex == widget.questions.length - 1;

    if (isLastQuestion) {
      setState(() {
        _isFinished = true;
      });
      return;
    }

    setState(() {
      _currentIndex++;
      _selectedOption = null;
      _hasAnswered = false;
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _correctCount = 0;
      _selectedOption = null;
      _hasAnswered = false;
      _isFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return _buildEmptyQuiz(context);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: _isFinished
            ? _buildScoreView(context)
            : _buildQuestionView(context),
      ),
    );
  }

  // ------------------------------------------------------------
  // Question Screen
  // ------------------------------------------------------------

  Widget _buildQuestionView(BuildContext context) {
    final theme = Theme.of(context);
    final totalQuestions = widget.questions.length;
    final progress = (_currentIndex + 1) / totalQuestions;

    return Stack(
      children: [
        // Decorative background circles
        Positioned(
          top: -90,
          right: -80,
          child: _BackgroundCircle(
            size: 210,
            color: AppTheme.primarySoft,
          ),
        ),

        Positioned(
          bottom: -100,
          left: -80,
          child: _BackgroundCircle(
            size: 220,
            color: AppTheme.primarySoft,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  _TopIconButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Study Quiz',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Test your understanding',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF77778D),
                          ),
                        ),
                      ],
                    ),
                  ),

                  _QuestionCounter(
                    current: _currentIndex + 1,
                    total: totalQuestions,
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Progress
              _QuizProgress(
                progress: progress,
                current: _currentIndex + 1,
                total: totalQuestions,
              ),

              const SizedBox(height: 22),

              // Question Card
              _QuestionCard(
                questionNumber: _currentIndex + 1,
                question: _currentQuestion.question,
              ),

              const SizedBox(height: 18),

              Text(
                'Choose the correct answer',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3C3C60),
                ),
              ),

              const SizedBox(height: 12),

              // Options
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: 2,
                    bottom: 12,
                  ),
                  itemCount: _currentQuestion.options.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 11),
                  itemBuilder: (context, index) {
                    final option = _currentQuestion.options[index];

                    return QuizOption(
                      optionText: option,
                      isSelected: _selectedOption == option,
                      isCorrectAnswer:
                          option == _currentQuestion.correctAnswer,
                      hasAnswered: _hasAnswered,
                      onTap: () => _selectOption(option),
                    );
                  },
                ),
              ),

              // Explanation
              if (_hasAnswered) ...[
                const SizedBox(height: 4),
                _ExplanationCard(
                  explanation: _currentQuestion.explanation,
                  isCorrect:
                      _selectedOption ==
                      _currentQuestion.correctAnswer,
                ),
                const SizedBox(height: 14),
              ],

              // Next Button
              PrimaryButton(
                label: _currentIndex == totalQuestions - 1
                    ? 'Finish Quiz'
                    : 'Next Question',
                icon: _currentIndex == totalQuestions - 1
                    ? Icons.check_rounded
                    : Icons.arrow_forward_rounded,
                onPressed: _hasAnswered ? _goToNext : null,
              ),

              const SizedBox(height: 6),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Score Screen
  // ------------------------------------------------------------

  Widget _buildScoreView(BuildContext context) {
    final theme = Theme.of(context);

    final total = widget.questions.length;
    final incorrectCount = total - _correctCount;

    final percentage = total == 0
        ? 0
        : ((_correctCount / total) * 100).round();

    final String resultTitle;
    final String resultMessage;
    final IconData resultIcon;

    if (percentage >= 80) {
      resultTitle = 'Excellent Work!';
      resultMessage =
          'Amazing! You have a strong understanding of this material.';
      resultIcon = Icons.emoji_events_rounded;
    } else if (percentage >= 50) {
      resultTitle = 'Good Job!';
      resultMessage =
          'You are doing well. A little more revision will make you even stronger.';
      resultIcon = Icons.thumb_up_alt_rounded;
    } else {
      resultTitle = 'Keep Learning!';
      resultMessage =
          'Review your study material and try the quiz again to improve your score.';
      resultIcon = Icons.menu_book_rounded;
    }

    return Stack(
      children: [
        // Background decoration
        Positioned(
          top: -100,
          left: -90,
          child: _BackgroundCircle(
            size: 240,
            color: AppTheme.primarySoft,
          ),
        ),

        Positioned(
          bottom: -120,
          right: -90,
          child: _BackgroundCircle(
            size: 260,
            color: AppTheme.primarySoft,
          ),
        ),

        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 22,
          ),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  _TopIconButton(
                    icon: Icons.close_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Quiz Result',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 34),

              // Result icon
              Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primarySoft,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5555C5)
                          .withValues(alpha: 0.12),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  resultIcon,
                  size: 42,
                  color: AppTheme.primary,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                resultTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                resultMessage,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: const Color(0xFF69697E),
                ),
              ),

              const SizedBox(height: 28),

              // Score Card
              _ScoreCard(
                percentage: percentage,
                correct: _correctCount,
                incorrect: incorrectCount,
                total: total,
              ),

              const SizedBox(height: 22),

              // Performance message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.78),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFE4E2F5),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9E8FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        size: 20,
                        color: Color(0xFF5555C5),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Every attempt helps you understand the topic better. Keep practicing!',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.45,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              PrimaryButton(
                label: 'Try Again',
                icon: Icons.refresh_rounded,
                onPressed: _restartQuiz,
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 19,
                  ),
                  label: const Text(
                    'Back to Study',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(
                      color: Color(0xFFD7D5F2),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Empty Quiz
  // ------------------------------------------------------------

  Widget _buildEmptyQuiz(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE9E8FF),
                  ),
                  child: const Icon(
                    Icons.quiz_outlined,
                    size: 46,
                    color: Color(0xFF5555C5),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  'No Questions Available',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'We could not find any quiz questions to display.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF6B6B80),
                      ),
                ),
                const SizedBox(height: 28),
                PrimaryButton(
                  label: 'Go Back',
                  icon: Icons.arrow_back_rounded,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// ============================================================
// Question Card
// ============================================================

class _QuestionCard extends StatelessWidget {
  final int questionNumber;
  final String question;

  const _QuestionCard({
    required this.questionNumber,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF0EFFF),
            Color(0xFFE8E7FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFDCD9FA),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5555C5).withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Color(0xFF5555C5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$questionNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'QUESTION',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: Color(0xFF5555C5),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            question,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                  color: const Color(0xFF292955),
                ),
          ),
        ],
      ),
    );
  }
}


// ============================================================
// Progress
// ============================================================

class _QuizProgress extends StatelessWidget {
  final double progress;
  final int current;
  final int total;

  const _QuizProgress({
    required this.progress,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Progress',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6D6D82),
              ),
            ),
            const Spacer(),
            Text(
              '$current / $total',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF5555C5),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: const Color(0xFFE4E2F2),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF6666D8),
            ),
          ),
        ),
      ],
    );
  }
}


// ============================================================
// Question Counter
// ============================================================

class _QuestionCounter extends StatelessWidget {
  final int current;
  final int total;

  const _QuestionCounter({
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE9E8FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$current/$total',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: Color(0xFF5555C5),
        ),
      ),
    );
  }
}


// ============================================================
// Explanation
// ============================================================

class _ExplanationCard extends StatelessWidget {
  final String explanation;
  final bool isCorrect;

  const _ExplanationCard({
    required this.explanation,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final icon = isCorrect
        ? Icons.check_circle_rounded
        : Icons.info_rounded;

    final title = isCorrect ? 'Correct!' : 'Answer Explanation';

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isCorrect
            ? const Color(0xFFEAF8F0)
            : const Color(0xFFFFF5E8),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: isCorrect
              ? const Color(0xFFCBEBD8)
              : const Color(0xFFF1DFC3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 22,
            color: isCorrect
                ? const Color(0xFF32915B)
                : const Color(0xFFC17A22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3C3C50),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  explanation,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xFF626274),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ============================================================
// Score Card
// ============================================================

class _ScoreCard extends StatelessWidget {
  final int percentage;
  final int correct;
  final int incorrect;
  final int total;

  const _ScoreCard({
    required this.percentage,
    required this.correct,
    required this.incorrect,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2E0F1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Percentage Circle
          SizedBox(
            width: 145,
            height: 145,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 145,
                  height: 145,
                  child: CircularProgressIndicator(
                    value: percentage / 100,
                    strokeWidth: 11,
                    backgroundColor: const Color(0xFFE8E6F3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(
                      Color(0xFF5B5BC7),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$percentage%',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppTheme.textPrimary,
                          ),
                    ),
                    const Text(
                      'Score',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF77778D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: _ScoreStat(
                  label: 'Correct',
                  value: '$correct',
                  icon: Icons.check_circle_rounded,
                  color: const Color(0xFF32915B),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ScoreStat(
                  label: 'Incorrect',
                  value: '$incorrect',
                  icon: Icons.cancel_rounded,
                  color: const Color(0xFFD45A5A),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ScoreStat(
                  label: 'Total',
                  value: '$total',
                  icon: Icons.quiz_rounded,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// ============================================================
// Score Stat
// ============================================================

class _ScoreStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _ScoreStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 13,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF77778D),
            ),
          ),
        ],
      ),
    );
  }
}


// ============================================================
// Top Icon Button
// ============================================================

class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.82),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFE4E2F2),
            ),
          ),
          child: Icon(
            icon,
            size: 21,
            color: const Color(0xFF3F3F67),
          ),
        ),
      ),
    );
  }
}


// ============================================================
// Background Circle
// ============================================================

class _BackgroundCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _BackgroundCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
} 