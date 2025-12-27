import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme_mode_enum.dart';
import 'theme_state.dart';

/// Cubit responsible for managing the application's theme state.
///
/// Handles:
/// - Loading saved theme preference from local storage
/// - Saving theme preference changes
/// - Converting theme preference to Flutter's [ThemeMode]
class ThemeCubit extends Cubit<ThemeState> {
  /// Key used to store theme preference in Hive box
  static const String _themeBoxName = 'theme_box';
  static const String _themeKey = 'theme_mode';

  Box? _themeBox;

  ThemeCubit() : super(ThemeState.initial());

  /// Initializes the cubit by loading saved theme preference
  Future<void> initialize() async {
    try {
      _themeBox = await Hive.openBox(_themeBoxName);
      final savedTheme = _themeBox?.get(_themeKey) as String?;
      final themePreference = AppThemeModeExtension.fromString(savedTheme);
      _updateTheme(themePreference);
    } catch (e) {
      // If loading fails, use system default
      _updateTheme(AppThemeMode.system);
    }
  }

  /// Sets the theme mode and persists it to local storage
  Future<void> setThemeMode(AppThemeMode mode) async {
    try {
      await _themeBox?.put(_themeKey, mode.toStorageString());
      _updateTheme(mode);
    } catch (e) {
      // Still update UI even if persistence fails
      _updateTheme(mode);
    }
  }

  /// Updates the state with the new theme preference
  void _updateTheme(AppThemeMode mode) {
    final themeMode = _convertToThemeMode(mode);
    emit(state.copyWith(themePreference: mode, themeMode: themeMode));
  }

  /// Converts [AppThemeMode] to Flutter's [ThemeMode]
  ThemeMode _convertToThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  /// Toggles between light and dark mode
  /// If current mode is system, it will switch to dark
  Future<void> toggleTheme() async {
    final newMode = state.themePreference == AppThemeMode.dark
        ? AppThemeMode.light
        : AppThemeMode.dark;
    await setThemeMode(newMode);
  }

  /// Checks if current theme is dark mode
  bool get isDarkMode => state.themeMode == ThemeMode.dark;

  /// Checks if current theme follows system
  bool get isSystemMode => state.themePreference == AppThemeMode.system;
}
