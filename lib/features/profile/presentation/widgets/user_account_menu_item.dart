import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class UserAccountMenuItem extends StatelessWidget {
  const UserAccountMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 15,
              height: 15,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: FontStyles.subTitle3.copyWith(color: AppColors.primary),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 15),
          ],
        ),
      ),
    );
  }
}
