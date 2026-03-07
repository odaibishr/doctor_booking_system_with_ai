import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class ReadDayCard extends StatelessWidget {
  final String dayName;
  final bool isDayOff;
  final String? startTime;
  final String? endTime;

  const ReadDayCard({
    super.key,
    required this.dayName,
    required this.isDayOff,
    this.startTime,
    this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: isDayOff
                  ? context.gray200Color
                  : context.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isDayOff
                  ? Icons.event_busy_rounded
                  : Icons.calendar_month_rounded,
              color: isDayOff ? context.gray400Color : context.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayName,
                  style: FontStyles.subTitle2.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isDayOff
                        ? context.gray400Color
                        : context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isDayOff ? 'عطلة أسبوعية' : 'متاح للمواعيد',
                  style: FontStyles.body3.copyWith(
                    color: isDayOff
                        ? context.gray400Color
                        : context.gray500Color,
                  ),
                ),
              ],
            ),
          ),
          if (!isDayOff && startTime != null && endTime != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: context.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${_to12h(startTime!)} - ${_to12h(endTime!)}',
                style: FontStyles.body1.copyWith(
                  color: context.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

String _to12h(String time24) {
  final parts = time24.split(':');
  int hour = int.tryParse(parts[0]) ?? 0;
  final minute = parts.length > 1 ? parts[1].padLeft(2, '0') : '00';
  final period = hour >= 12 ? 'م' : 'ص';
  if (hour == 0) hour = 12;
  if (hour > 12) hour -= 12;
  return '${hour.toString().padLeft(2, '0')}:$minute $period';
}
