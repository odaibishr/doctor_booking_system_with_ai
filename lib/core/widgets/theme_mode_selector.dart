import 'package:doctor_booking_system_with_ai/core/manager/theme/theme_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/manager/theme/theme_mode_enum.dart';
import 'package:doctor_booking_system_with_ai/core/manager/theme/theme_state.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A dialog widget that allows users to select their preferred theme mode.
///
/// Displays three options:
/// - System Default (follows device settings)
/// - Light Mode
/// - Dark Mode
class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

  /// Shows the theme selection dialog
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ThemeModeSelector(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle indicator
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.gray400Dark : AppColors.gray300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'المظهر',
                style: FontStyles.headLine4.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                'اختر وضع العرض المفضل لديك',
                style: FontStyles.body1.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.gray600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Theme Options
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      _ThemeOption(
                        mode: AppThemeMode.system,
                        icon: Icons.brightness_auto_rounded,
                        title: 'تلقائي (حسب النظام)',
                        subtitle: 'يتبع إعدادات جهازك',
                        isSelected:
                            state.themePreference == AppThemeMode.system,
                        onTap: () => _selectTheme(context, AppThemeMode.system),
                      ),
                      const SizedBox(height: 12),
                      _ThemeOption(
                        mode: AppThemeMode.light,
                        icon: Icons.light_mode_rounded,
                        title: 'الوضع الفاتح',
                        subtitle: 'ألوان فاتحة مريحة للعين',
                        isSelected: state.themePreference == AppThemeMode.light,
                        onTap: () => _selectTheme(context, AppThemeMode.light),
                      ),
                      const SizedBox(height: 12),
                      _ThemeOption(
                        mode: AppThemeMode.dark,
                        icon: Icons.dark_mode_rounded,
                        title: 'الوضع الداكن',
                        subtitle: 'مثالي للاستخدام الليلي',
                        isSelected: state.themePreference == AppThemeMode.dark,
                        onTap: () => _selectTheme(context, AppThemeMode.dark),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _selectTheme(BuildContext context, AppThemeMode mode) {
    context.read<ThemeCubit>().setThemeMode(mode);
    Navigator.of(context).pop();
  }
}

/// Individual theme option widget
class _ThemeOption extends StatelessWidget {
  final AppThemeMode mode;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.mode,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final backgroundColor = isDark ? AppColors.gray100Dark : AppColors.gray100;
    final selectedBackground = isDark
        ? AppColors.primaryDark.withAlpha(30)
        : AppColors.primary.withAlpha(20);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? selectedBackground : backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                // Icon Container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primaryColor
                        : (isDark ? AppColors.gray200Dark : AppColors.gray200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? AppColors.white
                        : (isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.gray600),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: FontStyles.subTitle2.copyWith(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.black,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: FontStyles.body2.copyWith(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.gray500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Selection indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? primaryColor : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? primaryColor
                          : (isDark
                                ? AppColors.gray400Dark
                                : AppColors.gray400),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 16,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
