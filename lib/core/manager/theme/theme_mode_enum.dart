/// Enum representing the available theme modes in the application.
///
/// This enum is used to track and persist the user's theme preference.
/// - [system]: Follows the device's system theme setting
/// - [light]: Forces light mode regardless of system setting
/// - [dark]: Forces dark mode regardless of system setting
enum AppThemeMode { system, light, dark }

/// Extension on [AppThemeMode] to provide helper methods
extension AppThemeModeExtension on AppThemeMode {
  /// Returns an Arabic display name for the theme mode
  String get displayNameAr {
    switch (this) {
      case AppThemeMode.system:
        return 'تلقائي (حسب النظام)';
      case AppThemeMode.light:
        return 'الوضع الفاتح';
      case AppThemeMode.dark:
        return 'الوضع الداكن';
    }
  }

  /// Returns an English display name for the theme mode
  String get displayNameEn {
    switch (this) {
      case AppThemeMode.system:
        return 'System Default';
      case AppThemeMode.light:
        return 'Light Mode';
      case AppThemeMode.dark:
        return 'Dark Mode';
    }
  }

  /// Converts string to [AppThemeMode]
  static AppThemeMode fromString(String? value) {
    switch (value) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
      default:
        return AppThemeMode.system;
    }
  }

  /// Converts [AppThemeMode] to string for storage
  String toStorageString() {
    switch (this) {
      case AppThemeMode.system:
        return 'system';
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
    }
  }
}
