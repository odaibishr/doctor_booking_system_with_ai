import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';

class HospitalDetailsServiceItem extends StatelessWidget {
  final String service;

  const HospitalDetailsServiceItem({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      // height: 50,
      child: Text(
        service,
        style: FontStyles.subTitle2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
