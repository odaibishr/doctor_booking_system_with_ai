import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class PriceLableWithIcon extends StatelessWidget {
  const PriceLableWithIcon({super.key, required this.price});
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/dollar-circle.svg',
          width: 10,
          height: 10,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(AppColors.gray300, BlendMode.srcIn),
        ),
        const SizedBox(width: 2),
        Text(
          '$price ريال',
          style: FontStyles.body3.copyWith(
            color: AppColors.gray300,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
