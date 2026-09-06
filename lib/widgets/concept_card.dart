import 'package:flutter/material.dart';
import 'package:studylens_ai/theme/app_theme.dart';

/// A single row used to display one key concept with a numbered badge.
///
/// Uses the central StudyLens-AI theme so the card remains visually
/// consistent across the entire application.
class ConceptCard extends StatelessWidget {
  final int index;
  final String concept;

  const ConceptCard({
    super.key,
    required this.index,
    required this.concept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number badge
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppTheme.primarySoft,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: const TextStyle(
                color: AppTheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          // Concept text
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 4,
              ),
              child: Text(
                concept,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}