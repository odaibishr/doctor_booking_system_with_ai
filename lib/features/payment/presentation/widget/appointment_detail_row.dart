import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class AppointmentDetailRow extends StatelessWidget {
  final String title;
  final String value;

  const AppointmentDetailRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: FontStyles.body1.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(value, style: FontStyles.body1.copyWith(color: AppColors.gray500)),
      ],
    );
  }
}
