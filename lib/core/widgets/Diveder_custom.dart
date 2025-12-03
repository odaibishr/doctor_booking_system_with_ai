import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.shade400,
            thickness: 1,
            endIndent: 10, // مسافة بعد الخط من الجهة اليمنى
          ),
        ),
        Text(
          'أو',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey.shade400,
            thickness: 1,
            indent: 10, // مسافة بعد الخط من الجهة اليسرى
          ),
        ),
      ],
    );
  }
}
