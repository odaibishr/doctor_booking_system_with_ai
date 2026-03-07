import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:flutter/material.dart';

class TimeField extends StatelessWidget {
  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  const TimeField({
    super.key,
    required this.label,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FontStyles.body2.copyWith(color: context.gray500Color),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: context.gray100Color,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.gray200Color),
            ),
            child: Row(
              children: [
                Text(
                  to12hFull(time),
                  style: FontStyles.subTitle3.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.access_time_rounded,
                  size: 18,
                  color: context.gray400Color,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
