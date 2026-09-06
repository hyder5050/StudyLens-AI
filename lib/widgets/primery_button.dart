 import 'package:flutter/material.dart';
import 'package:studylens_ai/theme/app_theme.dart';

/// A modern, full-width primary action button used across StudyLens-AI.
///
/// Supports:
/// - Optional icon
/// - Loading state
/// - Disabled state
/// - Soft shadow
/// - Rounded professional design
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: isDisabled
              ? null
              : [
                  BoxShadow(
                    color: const Color(0xFF5555C5).withValues(alpha: 0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 7),
                  ),
                ],
        ),
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor: const Color(0xFFD8D7EA),
            disabledForegroundColor: const Color(0xFF8A899B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isLoading
                ? const SizedBox(
                    key: ValueKey('loading'),
                    height: 23,
                    width: 23,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  )
                : Row(
                    key: const ValueKey('content'),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                      if (icon != null) ...[
                        const SizedBox(width: 10),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.16),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            size: 18,
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
} 
