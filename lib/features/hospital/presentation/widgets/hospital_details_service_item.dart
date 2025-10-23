import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';

class HospitalDetailsServiceItem extends StatelessWidget {
  final String service;

  const HospitalDetailsServiceItem({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(service, style: FontStyles.subTitle2),
        ],
      ),
    );
  }
}
