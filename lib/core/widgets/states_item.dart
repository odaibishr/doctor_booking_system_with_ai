import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class StatesItem extends StatelessWidget {
  const StatesItem({
    super.key,
    required this.icon,
    this.number,
    required this.text,
    this.onTap,
  });
  final String icon;
  final String? number;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: context.gray300Color,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              height: 24,
              width: 24,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                context.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 5),
          number != null
              ? Text(
                  number!,
                  style: FontStyles.body3.copyWith(fontWeight: FontWeight.bold),
                )
              : const SizedBox(),
          const SizedBox(height: 2),
          Text(
            text,
            style: FontStyles.body3.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.gray500,
            ),
          ),
        ],
      ),
    );
  }
}
