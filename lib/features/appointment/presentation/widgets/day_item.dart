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

  int _toDayNumber(int weekday) {
    const map = {
      DateTime.saturday: 1,
      DateTime.sunday: 2,
      DateTime.monday: 3,
      DateTime.tuesday: 4,
      DateTime.wednesday: 5,
      DateTime.thursday: 6,
      DateTime.friday: 7,
    };
    return map[weekday] ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = _isSameDay(date, selectedDate);
    final isToday = _isSameDay(date, DateTime.now());

    bool isScheduled = true;
    if (doctorSchedules != null && doctorSchedules!.isNotEmpty) {
      isScheduled = doctorSchedules!.any(
        (s) => (s.day?.dayNumber ?? s.dayId) == _toDayNumber(date.weekday),
      );
    }

    final isUnavailable = unavailableDays.any((d) => _isSameDay(d, date));
    final isDisabled = !isScheduled || isUnavailable;

    final monthName = DateFormat.MMMM('ar').format(date);
    final dayName = DateFormat.EEEE('ar').format(date);

    return GestureDetector(
      onTap: isDisabled
          ? () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'عذراً، هذا اليوم غير متاح للحجز لدى الطبيب',
                  textAlign: TextAlign.center,
                ),
                duration: Duration(milliseconds: 900),
                behavior: SnackBarBehavior.floating,
              ),
            )
          : () => onTap(date),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: isDisabled
              ? AppColors.getGray400(context)
              : isSelected
              ? AppColors.getPrimary(context)
              : AppColors.getGray200(context),
          borderRadius: BorderRadius.circular(14),
          border: isToday && !isSelected
              ? Border.all(color: AppColors.getPrimary(context), width: 2)
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.getPrimary(
                      context,
                    ).withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day} $monthName',
              style: FontStyles.body2.copyWith(
                color: isDisabled
                    ? AppColors.getGray500(context)
                    : isSelected
                    ? Colors.white
                    : AppColors.getTextPrimary(context),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              dayName,
              style: FontStyles.subTitle3.copyWith(
                color: isDisabled
                    ? AppColors.getGray500(context)
                    : isSelected
                    ? Colors.white
                    : AppColors.getPrimary(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
