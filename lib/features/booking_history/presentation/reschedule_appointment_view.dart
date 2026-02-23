import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/utils/schedule_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/appointment_bottom_bar.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/booking_confirmation_step.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/date_picker_card.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/step_indicator.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/time_period_selector.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/time_slot_selector.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/manager/booking_history_cubit/booking_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RescheduleAppointmentView extends StatefulWidget {
  final Booking booking;

  const RescheduleAppointmentView({super.key, required this.booking});

  @override
  State<RescheduleAppointmentView> createState() =>
      _RescheduleAppointmentViewState();
}

class _RescheduleAppointmentViewState extends State<RescheduleAppointmentView> {
  int _currentStep = 0;
  DateTime _selectedDate = DateTime.now();
  String? _selectedPeriodKey;
  String? _selectedTimeSlot;
  int? _selectedScheduleId;

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedPeriodKey = null;
      _selectedTimeSlot = null;
      _selectedScheduleId = null;
    });
  }

  void _handlePeriodSelected(String periodKey) {
    setState(() {
      _selectedPeriodKey = periodKey;
      final slots = timeSlotsForPeriod(
        widget.booking.doctor.schedules,
        _selectedDate,
        periodKey,
      );
      if (slots.isNotEmpty) {
        _selectedTimeSlot = slots.first;
        _selectedScheduleId = getCurrentSchedule(
          widget.booking.doctor.schedules,
          _selectedDate,
        )?.id;
      } else {
        _selectedTimeSlot = null;
        _selectedScheduleId = null;
      }
    });
  }

  void _handleTimeSelected(String timeSlot) {
    setState(() {
      _selectedTimeSlot = timeSlot;
      _selectedScheduleId = getCurrentSchedule(
        widget.booking.doctor.schedules,
        _selectedDate,
      )?.id;
    });
  }

  void _nextStep() {
    if (_currentStep == 0) {
      setState(() => _currentStep = 1);
    } else if (_currentStep == 1) {
      if ((_selectedTimeSlot ?? '').isEmpty) {
        context.showErrorToast('يرجى اختيار وقت مناسب أولاً');
        return;
      }
      setState(() => _currentStep = 2);
    } else if (_currentStep == 2) {
      _onReschedule();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  void _onReschedule() {
    final dateStr = DateFormat('yyyy-MM-dd', 'en').format(_selectedDate);
    context.read<BookingHistoryCubit>().rescheduleAppointment(
      widget.booking.id,
      dateStr,
      _selectedScheduleId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasSchedules = widget.booking.doctor.schedules?.isNotEmpty ?? false;

    return BlocListener<BookingHistoryCubit, BookingHistoryState>(
      listener: (context, state) {
        if (state is RescheduleAppointmentSuccess) {
          context.showSuccessToast('تم تعديل الموعد بنجاح');
          GoRouter.of(context).pop(true);
        } else if (state is RescheduleAppointmentError) {
          context.showErrorToast(state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(child: _buildMainContent(hasSchedules)),
        bottomNavigationBar: hasSchedules
            ? BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
                builder: (context, state) {
                  final isLoading = state is RescheduleAppointmentLoading;
                  if (isLoading) {
                    return Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                      child: const SafeArea(
                        top: false,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }
                  return AppointmentBottomBar(
                    currentStep: _currentStep,
                    onNext: _nextStep,
                    onBack: _previousStep,
                  );
                },
              )
            : null,
      ),
    );
  }

  Widget _buildMainContent(bool hasSchedules) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomAppBar(
            title: 'تعديل الموعد',
            isBackButtonVisible: true,
            isUserImageVisible: false,
            isHeartIconVisible: false,
          ),
        ),
        if (!hasSchedules)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'لا تتوفر مواعيد حالياً لهذا الطبيب',
                style: TextStyle(color: Colors.red),
              ),
            ),
          )
        else ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StepIndicator(currentStep: _currentStep),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildStepContent(),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return DatePickerCard(
          key: const ValueKey(0),
          selectedDate: _selectedDate,
          onDateSelected: _onDateSelected,
          doctorSchedules: widget.booking.doctor.schedules,
        );
      case 1:
        return Column(
          key: const ValueKey(1),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TimePeriodSelector(
              selectedPeriodKey: _selectedPeriodKey,
              onPeriodSelected: _handlePeriodSelected,
            ),
            const SizedBox(height: 16),
            TimeSlotSelector(
              slots: timeSlotsForPeriod(
                widget.booking.doctor.schedules,
                _selectedDate,
                _selectedPeriodKey,
              ),
              selectedSlot: _selectedTimeSlot,
              onSelected: _handleTimeSelected,
              disabledSlots: const {},
            ),
          ],
        );
      case 2:
        return BookingConfirmationStep(
          key: const ValueKey(2),
          doctor: widget.booking.doctor,
          selectedDate: _selectedDate,
          selectedTime: _selectedTimeSlot ?? '',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
