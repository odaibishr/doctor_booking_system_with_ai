
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ChartColumn extends StatelessWidget {
   final double coulmnHeight;
  const ChartColumn({
    super.key, required this.coulmnHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: coulmnHeight,
      decoration: BoxDecoration(
        color: AppColors.gray300,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}