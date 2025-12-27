import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.moreText = 'إظهار المزيد',
    required this.onTap,
  });

  final String title;
  final String? moreText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.black;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: FontStyles.subTitle1.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            moreText!,
            style: FontStyles.body2.copyWith(color: primaryColor),
          ),
        ),
      ],
    );
  }
}
