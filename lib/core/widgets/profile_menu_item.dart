import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.trailing,
    this.isDestructive = false,
  });

  final String title;
  final String icon;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? context.errorColor
        : AppColors.getPrimary(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: context.cardBackgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 16,
              height: 16,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: FontStyles.subTitle3.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            trailing ??
                Icon(Icons.arrow_forward_ios, color: color, size: 14),
          ],
        ),
      ),
    );
  }
}
