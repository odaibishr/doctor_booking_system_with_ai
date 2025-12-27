import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

/// A menu item widget for the user account menu.
///
/// Supports dark mode and custom trailing widgets.
class UserAccountMenuItem extends StatelessWidget {
  const UserAccountMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.trailing,
  });

  final String title;
  final String icon;
  final Function() onTap;

  /// Optional trailing widget (defaults to arrow icon if not provided)
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final backgroundColor = isDark ? AppColors.gray100Dark : AppColors.gray100;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 15,
              height: 15,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: FontStyles.subTitle3.copyWith(color: primaryColor),
            ),
            const Spacer(),
            trailing ??
                Icon(Icons.arrow_forward_ios, color: primaryColor, size: 15),
          ],
        ),
      ),
    );
  }
}
