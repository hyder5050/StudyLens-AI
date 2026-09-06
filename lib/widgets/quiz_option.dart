 import 'package:flutter/material.dart';
import 'package:studylens_ai/theme/app_theme.dart';

/// A single tappable answer option in the quiz.
///
/// Visual state changes based on the user's answer:
/// - Default: clean theme-colored card.
/// - Selected: primary theme highlight.
/// - Correct: success state.
/// - Wrong: error state.
class QuizOption extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final bool isCorrectAnswer;
  final bool hasAnswered;
  final VoidCallback? onTap;

  const QuizOption({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.isCorrectAnswer,
    required this.hasAnswered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppTheme.surface;
    Color borderColor = AppTheme.border;
    Color textColor = AppTheme.textPrimary;

    IconData? trailingIcon;
    Color? trailingIconColor;

    // ------------------------------------------------------------
    // Answered state
    // ------------------------------------------------------------

    if (hasAnswered) {
      if (isCorrectAnswer) {
        backgroundColor =
            AppTheme.success.withValues(alpha: 0.08);

        borderColor =
            AppTheme.success.withValues(alpha: 0.55);

        textColor = AppTheme.success;

        trailingIcon = Icons.check_circle_rounded;
        trailingIconColor = AppTheme.success;
      } else if (isSelected) {
        backgroundColor =
            AppTheme.error.withValues(alpha: 0.08);

        borderColor =
            AppTheme.error.withValues(alpha: 0.55);

        textColor = AppTheme.error;

        trailingIcon = Icons.cancel_rounded;
        trailingIconColor = AppTheme.error;
      } else {
        // Other options become slightly muted.
        backgroundColor =
            AppTheme.background;

        borderColor =
            AppTheme.border;

        textColor = AppTheme.textSecondary;
      }
    }

    // ------------------------------------------------------------
    // Selected state before answering
    // ------------------------------------------------------------

    else if (isSelected) {
      backgroundColor =
          AppTheme.primarySoft;

      borderColor =
          AppTheme.primary;

      textColor =
          AppTheme.primary;
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.sm,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: hasAnswered ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor:
              AppTheme.primary.withValues(alpha: 0.08),
          highlightColor:
              AppTheme.primary.withValues(alpha: 0.04),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 17,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor,
                width: isSelected || hasAnswered
                    ? 1.5
                    : 1.0,
              ),
              boxShadow: [
                if (!hasAnswered)
                  BoxShadow(
                    color: AppTheme.primary
                        .withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Row(
              children: [
                // Option indicator
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected || hasAnswered
                        ? borderColor
                            .withValues(alpha: 0.12)
                        : AppTheme.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    _getOptionLetter(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: hasAnswered
                          ? borderColor
                          : isSelected
                              ? AppTheme.primary
                              : AppTheme.textSecondary,
                    ),
                  ),
                ),

                const SizedBox(width: 13),

                // Option text
                Expanded(
                  child: Text(
                    optionText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                          color: textColor,
                          fontWeight: isSelected ||
                                  hasAnswered
                              ? FontWeight.w600
                              : FontWeight.w500,
                          height: 1.35,
                        ),
                  ),
                ),

                // Correct / wrong icon
                if (trailingIcon != null) ...[
                  const SizedBox(width: 10),
                  Icon(
                    trailingIcon,
                    size: 24,
                    color: trailingIconColor,
                  ),
                ] else if (!hasAnswered) ...[
                  // Arrow for unanswered option
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 22,
                    color: isSelected
                        ? AppTheme.primary
                        : AppTheme.textMuted,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getOptionLetter() {
    // The letter is intentionally based on the option text
    // only when this widget is later extended with an index.
    //
    // For now, a simple bullet keeps the component independent.
    return '•';
  }
} 