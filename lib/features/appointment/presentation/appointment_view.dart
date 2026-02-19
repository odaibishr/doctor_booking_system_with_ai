import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/utils/schedule_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/appointment_bottom_bar.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/booking_confirmation_step.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/booking_success_overlay.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/date_picker_card.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/step_indicator.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/time_period_selector.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/time_slot_selector.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/manager/payment_cubit.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppointmentView extends StatefulWidget {
  final Doctor doctor;
  const AppointmentView({super.key, required this.doctor});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  int _currentStep = 0;
  DateTime _selectedDate = DateTime.now();
  String? _selectedPeriodKey;
  String? _selectedTime;
  int? _selectedScheduleId;
  bool _completePayment = false;

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedPeriodKey = null;
      _selectedTime = null;
      _selectedScheduleId = null;
    });
  }

  void _handlePeriodSelected(String periodKey) {
    setState(() {
      _selectedPeriodKey = periodKey;
      final slots = timeSlotsForPeriod(
        widget.doctor.schedules,
        _selectedDate,
        periodKey,
      );
      if (slots.isNotEmpty) {
        _selectedTime = slots.first;
        _selectedScheduleId = getCurrentSchedule(
          widget.doctor.schedules,
          _selectedDate,
        )?.id;
      } else {
        _selectedTime = null;
        _selectedScheduleId = null;
      }
    });
  }

  void _handleTimeSelected(String timeSlot) {
    setState(() {
      _selectedTime = timeSlot;
      _selectedScheduleId = getCurrentSchedule(
        widget.doctor.schedules,
        _selectedDate,
      )?.id;
    });
  }

  void _nextStep(BuildContext ctx) {
    if (_currentStep == 0) {
      setState(() => _currentStep = 1);
    } else if (_currentStep == 1) {
      if ((_selectedTime ?? '').isEmpty) {
        ctx.showErrorToast('يرجى اختيار وقت مناسب أولاً');
        return;
      }
      setState(() => _currentStep = 2);
    } else if (_currentStep == 2) {
      _confirmBooking(ctx);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  void _confirmBooking(BuildContext ctx) {
    ctx.read<PaymentCubit>().bookAppointment(
      doctorId: widget.doctor.id,
      doctorScheduleId: _selectedScheduleId,
      date: DateFormat('yyyy-MM-dd', 'en').format(_selectedDate),
      amount: widget.doctor.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasSchedules = widget.doctor.schedules?.isNotEmpty ?? false;

    return BlocProvider(
      create: (_) => serviceLocator<PaymentCubit>(),
      child: Builder(
        builder: (context) => BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            } else if (state is PaymentSuccess) {
              Navigator.of(context, rootNavigator: true).pop();
              setState(() => _completePayment = true);
            } else if (state is PaymentFailure) {
              Navigator.of(context, rootNavigator: true).pop();
              context.showErrorToast(state.errMessage);
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  _buildMainContent(hasSchedules),
                  if (_completePayment)
                    BookingSuccessOverlay(
                      doctorName: widget.doctor.name,
                      userName: HiveService.getCachedAuthData()?.name ?? '',
                      date: DateFormat.yMMMMd('ar').format(_selectedDate),
                      time: _selectedTime ?? '',
                    ),
                ],
              ),
            ),
            bottomNavigationBar: hasSchedules && !_completePayment
                ? AppointmentBottomBar(
                    currentStep: _currentStep,
                    onNext: () => _nextStep(context),
                    onBack: _previousStep,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(bool hasSchedules) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomAppBar(
            title: 'حجز موعد',
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
          doctorSchedules: widget.doctor.schedules,
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
                widget.doctor.schedules,
                _selectedDate,
                _selectedPeriodKey,
              ),
              selectedSlot: _selectedTime,
              onSelected: _handleTimeSelected,
              disabledSlots: const {},
            ),
          ],
        );
      case 2:
        return BookingConfirmationStep(
          key: const ValueKey(2),
          doctor: widget.doctor,
          selectedDate: _selectedDate,
          selectedTime: _selectedTime ?? '',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
