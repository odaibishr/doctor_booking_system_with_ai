import 'package:flutter/material.dart';
import 'date_picker_card.dart';
import 'time_period_selector.dart';
import 'time_slot_selector.dart';

class DataBooking extends StatefulWidget {
  final void Function(DateTime date)? onDateSelected;
  final void Function(String time)? onTimeSelected;

  const DataBooking({super.key, this.onDateSelected, this.onTimeSelected});

  @override
  State<DataBooking> createState() => _DataBookingState();
}

class _DataBookingState extends State<DataBooking> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedPeriodKey;
  String? _selectedTimeSlot;

  void _handleDateSelected(DateTime date) {
    setState(() => _selectedDate = date);
    widget.onDateSelected?.call(date);
  }

  void _handlePeriodSelected(String periodKey) {
    setState(() {
      _selectedPeriodKey = periodKey;
      _selectedTimeSlot = null;
    });
  }

  void _handleTimeSelected(String timeSlot) {
    setState(() => _selectedTimeSlot = timeSlot);
    widget.onTimeSelected?.call(timeSlot);
  }

  List<String> _timeSlotsForPeriod(String? periodKey) {
    if (periodKey == 'evening') {
      return const [
        '4:00 م',
        '4:30 م',
        '5:00 م',
        '5:30 م',
        '6:00 م',
        '6:30 م',
        '7:00 م',
        '7:30 م',
        '8:00 م',
      ];
    }
    return const [
      '10:00 ص',
      '10:30 ص',
      '11:00 ص',
      '11:30 ص',
      '12:00 م',
      '12:30 م',
      '1:00 م',
      '1:30 م',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DatePickerCard(
          selectedDate: _selectedDate,
          onDateSelected: _handleDateSelected,
        ),
        const SizedBox(height: 16),
        TimePeriodSelector(
          selectedPeriodKey: _selectedPeriodKey,
          onPeriodSelected: _handlePeriodSelected,
        ),
        const SizedBox(height: 16),
        TimeSlotSelector(
          slots: _timeSlotsForPeriod(_selectedPeriodKey),
          selectedSlot: _selectedTimeSlot,
          onSelected: _handleTimeSelected,
          disabledSlots: const {'11:30 ص', '6:30 م'},
        ),
      ],
    );
  }
}
