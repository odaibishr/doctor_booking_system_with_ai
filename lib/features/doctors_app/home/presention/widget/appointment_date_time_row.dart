import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class AppointmentDateTimeRow extends StatelessWidget {
  const AppointmentDateTimeRow({
    super.key,
    required this.date,
    required this.time,
  });

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.getGray200(context),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: context.primaryColor,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  date,
                  style: FontStyles.body1.copyWith(
                    color: context.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.access_time_outlined,
                size: 14,
                color: context.textTertiaryColor,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  time,
                  style: FontStyles.body2.copyWith(
                    color: context.textTertiaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
