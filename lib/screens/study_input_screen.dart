 
import 'package:flutter/material.dart';
import 'package:studylens_ai/models/sudy_result.dart';
import 'package:studylens_ai/widgets/primery_button.dart';

import '../config/api_config.dart';
import '../services/ai_study_service.dart';
import '../services/mock_ai_study_service.dart';
import '../services/real_ai_study_service.dart';
import '../theme/app_theme.dart';
import 'study_result_screen.dart';

/// Screen where the user pastes their study material and requests
/// AI-generated study material.
class StudyInputScreen extends StatefulWidget {
  final AiStudyService? aiStudyService;

  const StudyInputScreen({
    super.key,
    this.aiStudyService,
  });

  @override
  State<StudyInputScreen> createState() => _StudyInputScreenState();
}

class _StudyInputScreenState extends State<StudyInputScreen> {
  late final AiStudyService _aiStudyService;

  final TextEditingController _textController =
      TextEditingController();

  static const int _minimumCharacters = 40;

  String? _validationMessage;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();

    _aiStudyService = widget.aiStudyService ??
        (ApiConfig.useMockService
            ? MockAiStudyService()
            : RealAiStudyService());
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleClear() {
    setState(() {
      _textController.clear();
      _validationMessage = null;
    });
  }

  Future<void> _handleGenerate() async {
    if (_isGenerating) return;

    final text = _textController.text.trim();

    if (text.isEmpty) {
      setState(() {
        _validationMessage =
            'Please paste some study material first.';
      });
      return;
    }

    if (text.length < _minimumCharacters) {
      setState(() {
        _validationMessage =
            'Please enter a bit more study material so we have '
            'enough to work with.';
      });
      return;
    }

    setState(() {
      _validationMessage = null;
      _isGenerating = true;
    });

    try {
      final StudyResult result =
          await _aiStudyService.generateStudyMaterial(text);

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => StudyResultScreen(
            studyResult: result,
          ),
        ),
      );
    } on AiServiceException catch (e) {
      if (!mounted) return;

      setState(() {
        _validationMessage = e.message;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _validationMessage =
            'Something went wrong while generating your study '
            'material. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final characterCount = _textController.text.length;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            // --------------------------------------------------
            // Decorative background
            // --------------------------------------------------

            Positioned(
              top: -100,
              right: -80,
              child: _BackgroundCircle(
                size: 220,
                color: AppTheme.primarySoft
              ),
            ),

            Positioned(
              bottom: -120,
              left: -90,
              child: _BackgroundCircle(
                size: 250,
                color: AppTheme.primarySoft,
              ),
            ),

            // --------------------------------------------------
            // Main content
            // --------------------------------------------------

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  _buildHeader(context),

                  const SizedBox(height: 24),

                  // Intro section
                  _buildIntroSection(context),

                  const SizedBox(height: 18),

                  // Material input card
                  Expanded(
                    child: _buildMaterialInput(
                      context,
                      characterCount,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Validation message
                  if (_validationMessage != null) ...[
                    _buildValidationMessage(context),
                    const SizedBox(height: 12),
                  ],

                  // Bottom actions
                  _buildActions(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Header
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        _TopIconButton(
          icon: Icons.arrow_back_rounded,
          onTap: _isGenerating
              ? () {}
              : () => Navigator.of(context).pop(),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Study Material',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                    ),
              ),
              const SizedBox(height: 3),
              Text(
                'Give your material to AI',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                      color: const Color(0xFF77778D),
                    ),
              ),
            ],
          ),
        ),

        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppTheme.primarySoft,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.auto_awesome_rounded,
            color: Color(0xFF5555C5),
            size: 21,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Intro Section
  // ============================================================

  Widget _buildIntroSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF7777E5),
                Color(0xFF4B4BA5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            color: Colors.white,
            size: 23,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paste your study material',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF292955),
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'AI will turn it into clear notes, concepts and quizzes.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                      height: 1.4,
                      color: const Color(0xFF77778D),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Material Input
  // ============================================================

  Widget _buildMaterialInput(
    BuildContext context,
    int characterCount,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.90),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _validationMessage != null
              ? const Color(0xFFE29A9A)
              : const Color(0xFFE3E1F1),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Input header
          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              16,
              18,
              12,
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEBFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.edit_note_rounded,
                    size: 20,
                    color: Color(0xFF5555C5),
                  ),
                ),

                const SizedBox(width: 10),

                const Expanded(
                  child: Text(
                    'Your material',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF3D3D61),
                    ),
                  ),
                ),

                // Character count
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F1FA),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(
                    '$characterCount chars',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF77778D),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            height: 1,
            indent: 18,
            endIndent: 18,
            color: Color(0xFFEAE8F3),
          ),

          // Text field
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                18,
                4,
                18,
                8,
              ),
              child: TextField(
                controller: _textController,
                enabled: !_isGenerating,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
                onChanged: (_) {
                  if (_validationMessage != null) {
                    setState(() {
                      _validationMessage = null;
                    });
                  } else {
                    setState(() {});
                  }
                },
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.55,
                  color: Color(0xFF36364F),
                ),
                cursorColor: AppTheme.primary,
                decoration: const InputDecoration(
                  hintText:
                      'Paste your notes, lecture content,\n'
                      'book text or any study material here...',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF9A99AA),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                  ),
                ),
              ),
            ),
          ),

          // Helpful footer
          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              6,
              18,
              15,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: Color(0xFF89889A),
                ),
                const SizedBox(width: 6),
                const Expanded(
                  child: Text(
                    'Minimum 40 characters recommended',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF89889A),
                    ),
                  ),
                ),

                if (characterCount >= _minimumCharacters)
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: Color(0xFF4DA56B),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Validation Message
  // ============================================================

  Widget _buildValidationMessage(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEEEE),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFF2CCCC),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 20,
            color: AppTheme.error,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              _validationMessage!,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w600,
                color: Color(0xFFB04C4C),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Actions
  // ============================================================

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        // Clear button
        SizedBox(
          width: 130,
          height: 58,
          child: OutlinedButton.icon(
            onPressed: _isGenerating ? null : _handleClear,
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 19,
            ),
            label: const Text(
              'Clear',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF66667C),
              disabledForegroundColor:
                  const Color(0xFFB8B7C5),
              side: const BorderSide(
                color: Color(0xFFDAD8EA),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: PrimaryButton(
            label: 'Generate',
            icon: Icons.auto_awesome_rounded,
            isLoading: _isGenerating,
            onPressed: _handleGenerate,
          ),
        ),
      ],
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