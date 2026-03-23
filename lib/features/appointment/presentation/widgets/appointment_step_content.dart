import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/utils/schedule_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/booking_confirmation_step.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/date_picker_card.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/time_period_selector.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/time_slot_selector.dart';
import 'package:flutter/material.dart';

class AppointmentStepContent extends StatelessWidget {
  final int currentStep;
  final Doctor doctor;
  final DateTime selectedDate;
  final String? selectedPeriodKey;
  final String? selectedTime;
  final Function(DateTime) onDateSelected;
  final Function(String) onPeriodSelected;
  final Function(String) onTimeSelected;

  const AppointmentStepContent({
    super.key,
    required this.currentStep,
    required this.doctor,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onPeriodSelected,
    required this.onTimeSelected,
    this.selectedPeriodKey,
    this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentStep) {
      case 0:
        return DatePickerCard(
          key: const ValueKey(0),
          selectedDate: selectedDate,
          onDateSelected: onDateSelected,
          doctorSchedules: doctor.schedules,
        );
      case 1:
        return Column(
          key: const ValueKey(1),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TimePeriodSelector(
              selectedPeriodKey: selectedPeriodKey,
              onPeriodSelected: onPeriodSelected,
            ),
            const SizedBox(height: 16),
            TimeSlotSelector(
              slots: timeSlotsForPeriod(
                doctor.schedules,
                selectedDate,
                selectedPeriodKey,
              ),
              selectedSlot: selectedTime,
              onSelected: onTimeSelected,
              disabledSlots: const {},
            ),
          ],
        );
      case 2:
        return BookingConfirmationStep(
          key: const ValueKey(2),
          doctor: doctor,
          selectedDate: selectedDate,
          selectedTime: selectedTime ?? '',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
