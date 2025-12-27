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
            color: context.gray400Color,
            thickness: 1,
            endIndent: 10,
          ),
        ),
        Text(
          'أو',
          style: TextStyle(
            color: context.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(color: context.gray400Color, thickness: 1, indent: 10),
        ),
      ],
    );
  }
}
