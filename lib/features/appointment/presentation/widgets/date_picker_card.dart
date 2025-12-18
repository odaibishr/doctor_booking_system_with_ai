import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'day_item.dart';

class DatePickerCard extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(DateTime date) onDateSelected;

  const DatePickerCard({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
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
    final weekEnd = today.add(Duration(days: 7 - today.weekday));
    final nextWeekStart = weekEnd.add(const Duration(days: 1));
    final nextWeekEnd = nextWeekStart.add(const Duration(days: 6));

    final List<DateTime> allowedDates = List<DateTime>.generate(
      nextWeekEnd.difference(today).inDays + 1,
      (i) => DateTime(today.year, today.month, today.day + i),
    );

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
