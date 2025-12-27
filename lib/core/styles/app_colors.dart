import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF364989);
  static const Color secondary = Color(0xFF1E2846);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1A1A1A);
  static const Color error = Color(0xFFE55B48);
  static const Color success = Color(0xFF329930);
  static const Color successLight = Color(0x33329930);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color yellow = Color(0xFFFEB052);

  static Color? get primaryColor => primary;

  static const Color primaryDark = Color(0xFF5B7DD9);
  static const Color secondaryDark = Color(0xFF3D4F7A);
  static const Color scaffoldBackgroundDark = Color(0xFF121218);
  static const Color surfaceDark = Color(0xFF1E1E26);
  static const Color cardDark = Color(0xFF252530);
  static const Color textPrimaryDark = Color(0xFFEFEFF1);
  static const Color textSecondaryDark = Color(0xFFB0B0B8);
  static const Color textTertiaryDark = Color(0xFF8A8A94);
  static const Color gray100Dark = Color(0xFF252530);
  static const Color gray200Dark = Color(0xFF323240);
  static const Color gray300Dark = Color(0xFF424252);
  static const Color gray400Dark = Color(0xFF6B6B7B);
  static const Color gray500Dark = Color(0xFF9090A0);
  static const Color gray600Dark = Color(0xFFB0B0C0);
  static const Color errorDark = Color(0xFFFF6B5B);
  static const Color successDark = Color(0xFF4CAF50);
  static const Color successLightDark = Color(0x334CAF50);
  static const Color yellowDark = Color(0xFFFFB74D);
  static const Color dividerDark = Color(0xFF2E2E3A);

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color getPrimary(BuildContext context) =>
      isDark(context) ? primaryDark : primary;
  static Color getSecondary(BuildContext context) =>
      isDark(context) ? secondaryDark : secondary;
  static Color getScaffoldBackground(BuildContext context) =>
      isDark(context) ? scaffoldBackgroundDark : white;
  static Color getSurface(BuildContext context) =>
      isDark(context) ? surfaceDark : white;
  static Color getCard(BuildContext context) =>
      isDark(context) ? cardDark : white;
  static Color getCardBackground(BuildContext context) =>
      isDark(context) ? gray100Dark : gray100;
  static Color getTextPrimary(BuildContext context) =>
      isDark(context) ? textPrimaryDark : black;
  static Color getTextSecondary(BuildContext context) =>
      isDark(context) ? textSecondaryDark : gray600;
  static Color getTextTertiary(BuildContext context) =>
      isDark(context) ? textTertiaryDark : gray500;
  static Color getGray100(BuildContext context) =>
      isDark(context) ? gray100Dark : gray100;
  static Color getGray200(BuildContext context) =>
      isDark(context) ? gray200Dark : gray200;
  static Color getGray300(BuildContext context) =>
      isDark(context) ? gray300Dark : gray300;
  static Color getGray400(BuildContext context) =>
      isDark(context) ? gray400Dark : gray400;
  static Color getGray500(BuildContext context) =>
      isDark(context) ? gray500Dark : gray500;
  static Color getGray600(BuildContext context) =>
      isDark(context) ? gray600Dark : gray600;
  static Color getError(BuildContext context) =>
      isDark(context) ? errorDark : error;
  static Color getSuccess(BuildContext context) =>
      isDark(context) ? successDark : success;
  static Color getSuccessLight(BuildContext context) =>
      isDark(context) ? successLightDark : successLight;
  static Color getYellow(BuildContext context) =>
      isDark(context) ? yellowDark : yellow;
  static Color getDivider(BuildContext context) =>
      isDark(context) ? dividerDark : gray200;
  static Color getShadow(BuildContext context) => isDark(context)
      ? Colors.black.withAlpha(100)
      : Colors.black.withAlpha(25);
}

extension ThemeColors on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get primaryColor =>
      isDarkMode ? AppColors.primaryDark : AppColors.primary;
  Color get secondaryColor =>
      isDarkMode ? AppColors.secondaryDark : AppColors.secondary;
  Color get whiteColor => AppColors.white;
  Color get blackColor =>
      isDarkMode ? AppColors.textPrimaryDark : AppColors.black;

  Color get scaffoldBackgroundColor =>
      isDarkMode ? AppColors.scaffoldBackgroundDark : AppColors.white;
  Color get surfaceColor =>
      isDarkMode ? AppColors.surfaceDark : AppColors.white;
  Color get cardColor => isDarkMode ? AppColors.cardDark : AppColors.white;
  Color get cardBackgroundColor =>
      isDarkMode ? AppColors.gray100Dark : AppColors.gray100;

  Color get textPrimaryColor =>
      isDarkMode ? AppColors.textPrimaryDark : AppColors.black;
  Color get textSecondaryColor =>
      isDarkMode ? AppColors.textSecondaryDark : AppColors.gray600;
  Color get textTertiaryColor =>
      isDarkMode ? AppColors.textTertiaryDark : AppColors.gray500;

  Color get gray100Color =>
      isDarkMode ? AppColors.gray100Dark : AppColors.gray100;
  Color get gray200Color =>
      isDarkMode ? AppColors.gray200Dark : AppColors.gray200;
  Color get gray300Color =>
      isDarkMode ? AppColors.gray300Dark : AppColors.gray300;
  Color get gray400Color =>
      isDarkMode ? AppColors.gray400Dark : AppColors.gray400;
  Color get gray500Color =>
      isDarkMode ? AppColors.gray500Dark : AppColors.gray500;
  Color get gray600Color =>
      isDarkMode ? AppColors.gray600Dark : AppColors.gray600;

  Color get errorColor => isDarkMode ? AppColors.errorDark : AppColors.error;
  Color get successColor =>
      isDarkMode ? AppColors.successDark : AppColors.success;
  Color get successLightColor =>
      isDarkMode ? AppColors.successLightDark : AppColors.successLight;
  Color get yellowColor => isDarkMode ? AppColors.yellowDark : AppColors.yellow;

  Color get dividerColor =>
      isDarkMode ? AppColors.dividerDark : AppColors.gray200;
  Color get shadowColor =>
      isDarkMode ? Colors.black.withAlpha(100) : Colors.black.withAlpha(25);
}
