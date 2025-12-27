import 'package:flutter/material.dart';

/// Application color palette for both Light and Dark themes.
///
/// Colors are organized into:
/// - Main Colors (primary, secondary)
/// - Base Colors (white, black)
/// - Status Colors (error, success)
/// - Gray Colors (gray100-gray600)
/// - Accent Colors (yellow)
/// - Dark Theme specific colors
class AppColors {
  // ============================================================
  // LIGHT THEME COLORS
  // ============================================================

  // Main Colors
  static const Color primary = Color(0xFF364989);
  static const Color secondary = Color(0xFF1E2846);

  // Base Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1A1A1A);

  // Status Colors
  static const Color error = Color(0xFFE55B48);
  static const Color success = Color(0xFF329930);
  static const Color successLight = Color(0x33329930);

  // Gray Colors (Light Theme)
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);

  // Yellow Color
  static const Color yellow = Color(0xFFFEB052);

  static Color? get primaryColor => null;

  // ============================================================
  // DARK THEME COLORS
  // ============================================================

  // Dark Theme Primary Colors (lighter version for better visibility)
  static const Color primaryDark = Color(0xFF5B7DD9);
  static const Color secondaryDark = Color(0xFF3D4F7A);

  // Dark Theme Background Colors
  static const Color scaffoldBackgroundDark = Color(0xFF121218);
  static const Color surfaceDark = Color(0xFF1E1E26);
  static const Color cardDark = Color(0xFF252530);

  // Dark Theme Text Colors
  static const Color textPrimaryDark = Color(0xFFEFEFF1);
  static const Color textSecondaryDark = Color(0xFFB0B0B8);
  static const Color textTertiaryDark = Color(0xFF8A8A94);

  // Dark Theme Gray Colors (inverted for dark mode)
  static const Color gray100Dark = Color(0xFF252530);
  static const Color gray200Dark = Color(0xFF323240);
  static const Color gray300Dark = Color(0xFF424252);
  static const Color gray400Dark = Color(0xFF6B6B7B);
  static const Color gray500Dark = Color(0xFF9090A0);
  static const Color gray600Dark = Color(0xFFB0B0C0);

  // Dark Theme Status Colors (slightly brighter for visibility)
  static const Color errorDark = Color(0xFFFF6B5B);
  static const Color successDark = Color(0xFF4CAF50);
  static const Color successLightDark = Color(0x334CAF50);

  // Dark Theme Accent
  static const Color yellowDark = Color(0xFFFFB74D);

  // Dark Theme Divider
  static const Color dividerDark = Color(0xFF2E2E3A);

  // ============================================================
  // HELPER METHODS FOR THEME-AWARE COLORS
  // ============================================================

  /// Returns the appropriate gray100 color based on brightness
  static Color getGray100(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? gray100Dark
        : gray100;
  }

  /// Returns the appropriate gray200 color based on brightness
  static Color getGray200(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? gray200Dark
        : gray200;
  }

  /// Returns the appropriate gray400 color based on brightness
  static Color getGray400(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? gray400Dark
        : gray400;
  }

  /// Returns the appropriate surface color based on brightness
  static Color getSurface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? surfaceDark
        : white;
  }

  /// Returns the appropriate card color based on brightness
  static Color getCard(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? cardDark : white;
  }

  /// Returns the appropriate primary color based on brightness
  static Color getPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? primaryDark
        : primary;
  }

  /// Returns the appropriate text color based on brightness
  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textPrimaryDark
        : black;
  }

  /// Returns the appropriate secondary text color based on brightness
  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textSecondaryDark
        : gray600;
  }
}
