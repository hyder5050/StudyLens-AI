import 'package:flutter/material.dart';

/// Central place for StudyLens-AI visual style.
///
/// Keeping the theme in one file makes it easy to maintain:
/// - Colors
/// - Typography
/// - Buttons
/// - Cards
/// - Input fields
/// - App bars
/// - Common spacing
class AppTheme {
  AppTheme._();

  // ---------------------------------------------------------------------------
  // Brand Colors
  // ---------------------------------------------------------------------------

  static const Color primary = Color(0xFF5555C5);
  static const Color primaryLight = Color(0xFF6666D8);
  static const Color primarySoft = Color(0xFFE9E7FF);

  static const Color background = Color(0xFFFAF8FF);
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF20205A);
  static const Color textSecondary = Color(0xFF68677A);
  static const Color textMuted = Color(0xFF9291A3);

  static const Color border = Color(0xFFE4E3FF);
  static const Color success = Color(0xFF3FA66B);
  static const Color error = Color(0xFFD9536A);

  /// Kept for compatibility with code that may already use `seedColor`.
  static const Color seedColor = primary;

  // ---------------------------------------------------------------------------
  // Light Theme
  // ---------------------------------------------------------------------------

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primarySoft,
      onPrimaryContainer: textPrimary,

      surface: surface,
      onSurface: textPrimary,

      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: const Color(0xFFF7F5FC),
      surfaceContainer: const Color(0xFFF2F0F9),

      outline: border,
      outlineVariant: border,

      error: error,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,

      // -----------------------------------------------------------------------
      // Color Scheme
      // -----------------------------------------------------------------------

      colorScheme: colorScheme,

      scaffoldBackgroundColor: background,

      // -----------------------------------------------------------------------
      // App Bar
      // -----------------------------------------------------------------------

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,

        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),

        iconTheme: IconThemeData(
          color: textPrimary,
          size: 22,
        ),
      ),

      // -----------------------------------------------------------------------
      // Cards
      // -----------------------------------------------------------------------

      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // -----------------------------------------------------------------------
      // Elevated Buttons
      // -----------------------------------------------------------------------

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primary,
          foregroundColor: Colors.white,

          minimumSize: const Size.fromHeight(56),

          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // -----------------------------------------------------------------------
      // Outlined Buttons
      // -----------------------------------------------------------------------

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,

          minimumSize: const Size.fromHeight(56),

          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),

          side: const BorderSide(
            color: border,
            width: 1.2,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // -----------------------------------------------------------------------
      // Text Buttons
      // -----------------------------------------------------------------------

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // -----------------------------------------------------------------------
      // Input Fields
      // -----------------------------------------------------------------------

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF8F7FC),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),

        hintStyle: const TextStyle(
          color: textMuted,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),

        labelStyle: const TextStyle(
          color: textSecondary,
          fontSize: 15,
        ),

        floatingLabelStyle: const TextStyle(
          color: primary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: border,
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: primary,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: error,
            width: 1,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: error,
            width: 1.5,
          ),
        ),

        errorStyle: const TextStyle(
          color: error,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),

      // -----------------------------------------------------------------------
      // Checkbox
      // -----------------------------------------------------------------------

      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),

        side: const BorderSide(
          color: border,
          width: 1.5,
        ),

        fillColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return primary;
            }

            return Colors.transparent;
          },
        ),

        checkColor: WidgetStateProperty.all(Colors.white),
      ),

      // -----------------------------------------------------------------------
      // Switch
      // -----------------------------------------------------------------------

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }

            return textMuted;
          },
        ),

        trackColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return primary;
            }

            return const Color(0xFFE2E0EA);
          },
        ),
      ),

      // -----------------------------------------------------------------------
      // Progress Indicators
      // -----------------------------------------------------------------------

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: primarySoft,
        circularTrackColor: primarySoft,
      ),

      // -----------------------------------------------------------------------
      // Divider
      // -----------------------------------------------------------------------

      dividerTheme: const DividerThemeData(
        color: border,
        thickness: 1,
        space: 1,
      ),

      // -----------------------------------------------------------------------
      // SnackBar
      // -----------------------------------------------------------------------

      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimary,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      // -----------------------------------------------------------------------
      // Dialog
      // -----------------------------------------------------------------------

      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),

        titleTextStyle: const TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),

        contentTextStyle: const TextStyle(
          color: textSecondary,
          fontSize: 15,
          height: 1.5,
        ),
      ),

      // -----------------------------------------------------------------------
      // Typography
      // -----------------------------------------------------------------------

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textPrimary,
          fontSize: 36,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
        ),

        displayMedium: TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),

        displaySmall: TextStyle(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),

        headlineLarge: TextStyle(
          color: textPrimary,
          fontSize: 26,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.4,
        ),

        headlineMedium: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),

        headlineSmall: TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),

        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),

        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),

        titleSmall: TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),

        bodyLarge: TextStyle(
          color: textSecondary,
          fontSize: 16,
          height: 1.5,
        ),

        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 14,
          height: 1.5,
        ),

        bodySmall: TextStyle(
          color: textMuted,
          fontSize: 12,
          height: 1.4,
        ),

        labelLarge: TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),

        labelMedium: TextStyle(
          color: textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),

        labelSmall: TextStyle(
          color: textMuted,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Shared spacing constants.
///
/// Use these values throughout the app instead of repeatedly creating
/// different padding and gap values.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  // Additional useful spacing values for larger screens/cards.
  static const double xxl = 40;
  static const double xxxl = 48;
}