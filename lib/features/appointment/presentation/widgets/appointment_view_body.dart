import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/appointment_header.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/appointment_step_content.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/booking_success_overlay.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/no_schedules_view.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/step_indicator.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor_details/doctor_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentViewBody extends StatelessWidget {
  final DoctorDetailsState state;
  final Doctor initialDoctor;
  final int currentStep;
  final DateTime selectedDate;
  final String? selectedPeriodKey;
  final String? selectedTime;
  final bool completePayment;
  final Function(DateTime) onDateSelected;
  final Function(String) onPeriodSelected;
  final Function(String) onTimeSelected;

  const AppointmentViewBody({
    super.key,
    required this.state,
    required this.initialDoctor,
    required this.currentStep,
    required this.selectedDate,
    required this.completePayment,
    required this.onDateSelected,
    required this.onPeriodSelected,
    required this.onTimeSelected,
    this.selectedPeriodKey,
    this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    Doctor doctorToUse = initialDoctor;
    if (state is DoctorDetailsLoaded && (state as DoctorDetailsLoaded).doctor.id == initialDoctor.id) {
      doctorToUse = (state as DoctorDetailsLoaded).doctor;
    }

    final isLoading = state is DoctorDetailsLoading &&
        (doctorToUse.schedules == null || doctorToUse.schedules!.isEmpty);
    final hasSchedules = doctorToUse.schedules?.isNotEmpty ?? false;

    return Stack(
      children: [
        if (isLoading)
          const Center(
            child: CustomLoader(loaderSize: kLoaderSize),
          )
        else if (state is DoctorDetailsError &&
            (doctorToUse.schedules == null || doctorToUse.schedules!.isEmpty))
          Center(
            child: Text((state as DoctorDetailsError).message,
                style: const TextStyle(color: Colors.red)),
          )
        else
          Column(
            children: [
              const AppointmentHeader(),
              if (!hasSchedules)
                const NoSchedulesView()
              else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: StepIndicator(currentStep: currentStep),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: AppointmentStepContent(
                        currentStep: currentStep,
                        doctor: doctorToUse,
                        selectedDate: selectedDate,
                        selectedPeriodKey: selectedPeriodKey,
                        selectedTime: selectedTime,
                        onDateSelected: onDateSelected,
                        onPeriodSelected: onPeriodSelected,
                        onTimeSelected: onTimeSelected,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        if (completePayment)
          BookingSuccessOverlay(
            doctorName: doctorToUse.name,
            userName: HiveService.getCachedAuthData()?.name ?? '',
            date: DateFormat.yMMMMd('ar').format(selectedDate),
            time: selectedTime ?? '',
          ),
      ],
    );
  }
}
