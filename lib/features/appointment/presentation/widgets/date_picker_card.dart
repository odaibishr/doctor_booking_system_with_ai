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
  final Set<DateTime> _unavailableDays = {};

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
    Intl.defaultLocale = 'ar';
    final today = DateTime.now();

    final allPotentialDates = List<DateTime>.generate(
      30,
      (i) => DateTime(today.year, today.month, today.day + i),
    );

    final allowedDates = allPotentialDates.where((date) {
      if (widget.doctorSchedules == null || widget.doctorSchedules!.isEmpty) {
        return true;
      }
      final targetDayNumber = _toDayNumber(date.weekday);
      return widget.doctorSchedules!.any(
        (s) => (s.day?.dayNumber ?? s.dayId) == targetDayNumber,
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'اختر يوم الحجز المناسب',
          style: FontStyles.headLine4.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          DateFormat.yMMMM('ar').format(widget.selectedDate),
          style: FontStyles.subTitle2.copyWith(
            color: AppColors.getPrimary(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.1,
          ),
          itemCount: allowedDates.length > 9 ? 9 : allowedDates.length,
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
      ],
    );
  }
}
