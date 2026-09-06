 import 'package:flutter/material.dart';
import 'package:studylens_ai/theme/app_theme.dart';
import 'package:studylens_ai/widgets/primery_button.dart';

import 'study_input_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToInputScreen(BuildContext context) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => const StudyInputScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Background decorative circles
            Positioned(
              top: -100,
              left: -90,
              child: _BackgroundCircle(
                size: 230,
                color: AppTheme.primarySoft,
              ),
            ),

            Positioned(
              bottom: -110,
              right: -80,
              child: _BackgroundCircle(
                size: 250,
                color: AppTheme.primarySoft,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: Column(
                children: [
                  const Spacer(),

                  // Logo
                  const _StudyLensLogo(),

                  const SizedBox(height: 28),

                  // App name
                  Text(
                    'StudyLens-AI',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.2,
                      color: AppTheme.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Subtitle
                  Text(
                    'Turn your study material into\n'
                    'clear notes, concepts & quizzes.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      height: 1.45,
                      color: AppTheme.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 34),

                  // Feature illustration
                  const _StudyFeatures(),

                  const Spacer(),

                  // Start button
                  PrimaryButton(
                    label: 'Start Studying',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () => _navigateToInputScreen(context),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ------------------------------------------------------------
// Background circle
// ------------------------------------------------------------

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


// ------------------------------------------------------------
// StudyLens Logo
// ------------------------------------------------------------

class _StudyLensLogo extends StatelessWidget {
  const _StudyLensLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      height: 145,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE4E3FF),
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Open book
            const Icon(
              Icons.menu_book_rounded,
              size: 105,
              color: Color(0xFF45458F),
            ),

            // Lens / eye
            Container(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(
                color: Color(0xFFF9F8FF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Color(0xFF45458F),
                    shape: BoxShape.circle,
                  ),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(7),
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Sparkle
            const Positioned(
              top: 5,
              right: 15,
              child: Icon(
                Icons.auto_awesome,
                size: 30,
                color: Color(0xFF6666D8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ------------------------------------------------------------
// Features section
// ------------------------------------------------------------

class _StudyFeatures extends StatelessWidget {
  const _StudyFeatures();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Books at bottom
          Positioned(
            bottom: 8,
            child: Column(
              children: [
                _Book(
                  width: 245,
                  height: 45,
                  color: AppTheme.primaryLight,
                ),
                const SizedBox(height: 4),
                _Book(
                  width: 260,
                  height: 45,
                  color: AppTheme.primary,
                ),
              ],
            ),
          ),

          // Floating document
          Positioned(
            top: 25,
            child: Transform.rotate(
              angle: -0.08,
              child: Container(
                width: 125,
                height: 145,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DocumentLine(width: 75),
                    const SizedBox(height: 14),
                    _DocumentLine(width: 90),
                    const SizedBox(height: 10),
                    _DocumentLine(width: 70),
                    const SizedBox(height: 10),
                    _DocumentLine(width: 82),
                    const SizedBox(height: 10),
                    _DocumentLine(width: 55),
                  ],
                ),
              ),
            ),
          ),

          // Notes
          const Positioned(
            left: 5,
            top: 65,
            child: _FeatureBubble(
              icon: Icons.lightbulb_outline_rounded,
              label: 'Notes',
            ),
          ),

          // Concepts
          const Positioned(
            right: 0,
            top: 20,
            child: _FeatureBubble(
              icon: Icons.psychology_outlined,
              label: 'Concepts',
            ),
          ),

          // Quizzes
          const Positioned(
            right: 5,
            bottom: 50,
            child: _FeatureBubble(
              icon: Icons.check_box_outlined,
              label: 'Quizzes',
            ),
          ),

          // Small sparkles
          const Positioned(
            left: 115,
            top: 15,
            child: Icon(
              Icons.auto_awesome,
              size: 18,
              color: Color(0xFF8C8CEB),
            ),
          ),

          const Positioned(
            right: 95,
            bottom: 85,
            child: Icon(
              Icons.auto_awesome,
              size: 20,
              color: Color(0xFF8C8CEB),
            ),
          ),
        ],
      ),
    );
  }
}


// ------------------------------------------------------------
// Book
// ------------------------------------------------------------

class _Book extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const _Book({
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 10,
          height: height * 0.65,
          margin: const EdgeInsets.only(right: 22),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}


// ------------------------------------------------------------
// Document line
// ------------------------------------------------------------

class _DocumentLine extends StatelessWidget {
  final double width;

  const _DocumentLine({
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 7,
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}


// ------------------------------------------------------------
// Feature bubble
// ------------------------------------------------------------

class _FeatureBubble extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureBubble({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primarySoft,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 22,
            color: AppTheme.primary,
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}