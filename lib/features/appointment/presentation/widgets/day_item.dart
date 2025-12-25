import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';

class DayItem extends StatelessWidget {
  final DateTime date;
  final DateTime selectedDate;
  final Set<DateTime> unavailableDays;
  final List<DoctorSchedule>? doctorSchedules;
  final void Function(DateTime date) onTap;

  const DayItem({
    super.key,
    required this.date,
    required this.selectedDate,
    required this.unavailableDays,
    this.doctorSchedules,
    required this.onTap,
  });

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isToday = _isSameDay(date, today);
    final isSelected = _isSameDay(date, selectedDate);

    // Check if day is in doctor's schedule
    bool isScheduled = true;
    if (doctorSchedules != null && doctorSchedules!.isNotEmpty) {
      int targetDayNumber = 0;
      switch (date.weekday) {
        case DateTime.saturday:
          targetDayNumber = 1;
          break;
        case DateTime.sunday:
          targetDayNumber = 2;
          break;
        case DateTime.monday:
          targetDayNumber = 3;
          break;
        case DateTime.tuesday:
          targetDayNumber = 4;
          break;
        case DateTime.wednesday:
          targetDayNumber = 5;
          break;
        case DateTime.thursday:
          targetDayNumber = 6;
          break;
        case DateTime.friday:
          targetDayNumber = 7;
          break;
      }
      isScheduled = doctorSchedules!.any(
        (s) => (s.day?.dayNumber ?? s.dayId) == targetDayNumber,
      );
    }

    final isUnavailable = unavailableDays.any((d) => _isSameDay(d, date));
    final isDisabled = !isScheduled || isUnavailable;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: isDisabled
            ? () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'عذراً، هذا اليوم غير متاح للحجز لدى الطبيب',
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(milliseconds: 900),
                  behavior: SnackBarBehavior.floating,
                ),
              )
            : () => onTap(date),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isDisabled
                ? AppColors.gray400
                : isSelected
                ? AppColors.primary
                : AppColors.gray200,
            borderRadius: BorderRadius.circular(14),
            border: isToday && !isSelected
                ? Border.all(color: AppColors.primary, width: 2)
                : null,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.gray300.withValues(alpha: 0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat.E('ar').format(date),
                style: FontStyles.subTitle3.copyWith(
                  color: isDisabled
                      ? AppColors.gray500
                      : isSelected
                      ? AppColors.white
                      : AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${date.day}',
                style: FontStyles.headLine4.copyWith(
                  fontSize: 18,
                  color: isDisabled
                      ? AppColors.gray500
                      : isSelected
                      ? AppColors.white
                      : AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
