import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class TopDoctor extends StatelessWidget {
  const TopDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.gray200,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/verify.svg',
            width: 12,
            height: 12,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(width: 5),
          Text(
            'افضل الدكاترة',
            style: FontStyles.body2.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
