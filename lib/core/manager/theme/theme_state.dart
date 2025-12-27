import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'theme_mode_enum.dart';

/// State class for the Theme Cubit.
///
/// Contains the current theme mode preference and the resolved [ThemeMode]
/// that should be used by the MaterialApp.
class ThemeState extends Equatable {
  /// The user's theme preference
  final AppThemeMode themePreference;

  /// The resolved Flutter [ThemeMode] based on the preference
  final ThemeMode themeMode;

  const ThemeState({required this.themePreference, required this.themeMode});

  /// Creates initial state with system theme
  factory ThemeState.initial() {
    return const ThemeState(
      themePreference: AppThemeMode.system,
      themeMode: ThemeMode.system,
    );
  }

  /// Creates a copy of this state with the given fields replaced
  ThemeState copyWith({AppThemeMode? themePreference, ThemeMode? themeMode}) {
    return ThemeState(
      themePreference: themePreference ?? this.themePreference,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [themePreference, themeMode];
}
