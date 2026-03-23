import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/utils/schedule_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/appointment_bottom_bar.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/appointment_view_body.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/manager/payment_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor_details/doctor_details_cubit.dart';
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
  late Doctor _currentDoctor;

  @override
  void initState() {
    super.initState();
    _currentDoctor = widget.doctor;
    if (_currentDoctor.schedules == null || _currentDoctor.schedules!.isEmpty) {
      context.read<DoctorDetailsCubit>().getDoctorsDetails(_currentDoctor.id);
    }
  }

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
        _currentDoctor.schedules,
        _selectedDate,
        periodKey,
      );
      if (slots.isNotEmpty) {
        _selectedTime = slots.first;
        _selectedScheduleId = getCurrentSchedule(
          _currentDoctor.schedules,
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
        _currentDoctor.schedules,
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
      doctorId: _currentDoctor.id,
      doctorScheduleId: _selectedScheduleId,
      date: DateFormat('yyyy-MM-dd', 'en').format(_selectedDate),
      amount: _currentDoctor.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<PaymentCubit>(),
      child: Builder(
        builder: (context) => MultiBlocListener(
          listeners: [
            BlocListener<PaymentCubit, PaymentState>(
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
            ),
            BlocListener<DoctorDetailsCubit, DoctorDetailsState>(
              listener: (context, state) {
                if (state is DoctorDetailsLoaded &&
                    state.doctor.id == widget.doctor.id) {
                  setState(() {
                    _currentDoctor = state.doctor;
                  });
                }
              },
            ),
          ],
          child: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
            builder: (context, state) {
              final doctorToUse =
                  (state is DoctorDetailsLoaded &&
                      state.doctor.id == widget.doctor.id)
                  ? state.doctor
                  : _currentDoctor;

              final hasSchedules = doctorToUse.schedules?.isNotEmpty ?? false;

              return Scaffold(
                body: SafeArea(
                  child: AppointmentViewBody(
                    state: state,
                    initialDoctor: _currentDoctor,
                    currentStep: _currentStep,
                    selectedDate: _selectedDate,
                    completePayment: _completePayment,
                    selectedPeriodKey: _selectedPeriodKey,
                    selectedTime: _selectedTime,
                    onDateSelected: _onDateSelected,
                    onPeriodSelected: _handlePeriodSelected,
                    onTimeSelected: _handleTimeSelected,
                  ),
                ),
                bottomNavigationBar: hasSchedules && !_completePayment
                    ? AppointmentBottomBar(
                        currentStep: _currentStep,
                        onNext: () => _nextStep(context),
                        onBack: _previousStep,
                      )
                    : null,
              );
            },
          ),
        ),
      ),
    );
  }
}
