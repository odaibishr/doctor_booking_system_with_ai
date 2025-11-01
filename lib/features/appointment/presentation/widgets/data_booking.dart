import 'package:flutter/material.dart';
import 'date_picker_card.dart';
import 'time_period_selector.dart';

class DataBooking extends StatefulWidget {
  final void Function(DateTime date)? onDateSelected;

  const DataBooking({super.key, this.onDateSelected});

  @override
  State<DataBooking> createState() => _DataBookingState();
}

class _DataBookingState extends State<DataBooking> {
  DateTime _selectedDate = DateTime.now();

  void _handleDateSelected(DateTime date) {
    setState(() => _selectedDate = date);
    widget.onDateSelected?.call(date);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DatePickerCard(
              selectedDate: _selectedDate,
              onDateSelected: _handleDateSelected,
            ),
            const SizedBox(height: 24),
            const TimePeriodSelector(),
          ],
        ),
      ),
    );
  }
}
