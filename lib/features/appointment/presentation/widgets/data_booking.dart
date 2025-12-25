import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:flutter/material.dart';
import 'date_picker_card.dart';
import 'time_period_selector.dart';
import 'time_slot_selector.dart';

class DataBooking extends StatefulWidget {
  final Doctor doctor;
  final void Function(DateTime date)? onDateSelected;
  final void Function(String? time, int? scheduleId)? onTimeSelected;

  const DataBooking({
    super.key,
    required this.doctor,
    this.onDateSelected,
    this.onTimeSelected,
  });

  @override
  State<DataBooking> createState() => _DataBookingState();
}

class _DataBookingState extends State<DataBooking> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedPeriodKey;
  String? _selectedTimeSlot;

  void _handleDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedTimeSlot = null;
      _selectedPeriodKey = null;
    });
    widget.onDateSelected?.call(date);
    widget.onTimeSelected?.call(null, null);
  }

  void _handlePeriodSelected(String periodKey) {
    setState(() {
      _selectedPeriodKey = periodKey;
      final slots = _timeSlotsForPeriod(periodKey);
      if (slots.isNotEmpty) {
        _selectedTimeSlot = slots.first;
        final schedule = _getCurrentSchedule();
        if (schedule != null) {
          widget.onTimeSelected?.call(_selectedTimeSlot!, schedule.id);
        }
      } else {
        _selectedTimeSlot = null;
      }
    });
  }

  void _handleTimeSelected(String timeSlot) {
    setState(() => _selectedTimeSlot = timeSlot);
    final schedule = _getCurrentSchedule();
    if (schedule != null) {
      widget.onTimeSelected?.call(timeSlot, schedule.id);
    }
  }

  DoctorSchedule? _getCurrentSchedule() {
    if (widget.doctor.schedules == null || widget.doctor.schedules!.isEmpty) {
      return null;
    }

    int targetDayNumber = 0;
    switch (_selectedDate.weekday) {
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

    return widget.doctor.schedules!.firstWhere(
      (s) => (s.day?.dayNumber ?? s.dayId) == targetDayNumber,
      orElse: () => widget.doctor.schedules!.first,
    );
  }

  List<String> _timeSlotsForPeriod(String? periodKey) {
    if (widget.doctor.schedules == null || widget.doctor.schedules!.isEmpty) {
      return [];
    }

    // Find schedule for selected day
    // day_number in API: Saturday=1, Sunday=2...
    // DateTime.weekday: Monday=1, Tuesday=2, ..., Saturday=6, Sunday=7
    final schedule = widget.doctor.schedules!.firstWhere(
      (s) {
        final dayNumber = s.day?.dayNumber ?? s.dayId;
        // Map DateTime.weekday to API day_number (Saturday=1)
        // Saturday(6) -> 1
        // Sunday(7) -> 2
        // Monday(1) -> 3
        // Tuesday(2) -> 4
        // Wednesday(3) -> 5
        // Thursday(4) -> 6
        // Friday(5) -> 7
        int apiDayNumber = (_selectedDate.weekday + 1) % 7;
        if (apiDayNumber == 0)
          apiDayNumber = 7; // In case of offset logic differences
        // Let's assume the user's mapping: Saturday=1, Sunday=2...
        // My manual mapping above:
        int targetDayNumber = 0;
        switch (_selectedDate.weekday) {
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
        return dayNumber == targetDayNumber;
      },
      orElse: () => widget
          .doctor
          .schedules!
          .first, // Default to first if none match? or return empty
    );

    // If no schedule matches the selected day, technically the day shouldn't be selectable
    // For now, let's generate slots based on start/end time
    final startTime = schedule.startTime; // e.g. "08:00:00"
    final endTime = schedule.endTime; // e.g. "16:00:00"

    final List<String> slots = [];
    final start = int.parse(startTime.split(':')[0]);
    final end = int.parse(endTime.split(':')[0]);

    for (int h = start; h < end; h++) {
      final hourStr = h > 12 ? (h - 12).toString() : h.toString();
      final suffix = h >= 12 ? 'م' : 'ص';
      slots.add('$hourStr:00 $suffix');
      slots.add('$hourStr:30 $suffix');
    }

    // Filter by periodKey if needed (morning vs evening)
    if (periodKey == 'morning') {
      return slots.where((s) => s.contains('ص') || s.startsWith('12')).toList();
    } else if (periodKey == 'evening') {
      return slots
          .where((s) => s.contains('م') && !s.startsWith('12'))
          .toList();
    }

    return slots;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DatePickerCard(
          selectedDate: _selectedDate,
          onDateSelected: _handleDateSelected,
          doctorSchedules: widget.doctor.schedules,
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
