import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'day_item.dart';

class DatePickerCard extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(DateTime date) onDateSelected;
  final List<DoctorSchedule>? doctorSchedules;

  const DatePickerCard({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.doctorSchedules,
  });

  @override
  State<DatePickerCard> createState() => _DatePickerCardState();
}

class _DatePickerCardState extends State<DatePickerCard> {
  final Set<DateTime> _unavailableDays = {
    DateTime(2025, 7, 1),
    DateTime(2025, 7, 3),
    DateTime(2025, 7, 7),
  };

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'ar';
    final today = DateTime.now();

    final List<DateTime> allPotentialDates = List<DateTime>.generate(
      30, // Show next 30 days
      (i) => DateTime(today.year, today.month, today.day + i),
    );

    final List<DateTime> allowedDates = allPotentialDates.where((date) {
      if (widget.doctorSchedules == null || widget.doctorSchedules!.isEmpty) {
        return true; // If no schedules, allow all? or none? Let's say all for now.
      }

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

      return widget.doctorSchedules!.any(
        (s) => (s.day?.dayNumber ?? s.dayId) == targetDayNumber,
      );
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray300.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'اختر يوم الحجز المناسب',
            style: FontStyles.headLine4.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            DateFormat.yMMMM('ar').format(widget.selectedDate),
            style: FontStyles.subTitle2.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: allowedDates.length,
              itemBuilder: (context, index) {
                return DayItem(
                  date: allowedDates[index],
                  selectedDate: widget.selectedDate,
                  unavailableDays: _unavailableDays,
                  doctorSchedules: widget.doctorSchedules,
                  onTap: widget.onDateSelected,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
