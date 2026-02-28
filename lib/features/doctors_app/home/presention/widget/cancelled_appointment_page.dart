import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/dappointment_card.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/appointments/doctor_appointments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelledAppointmentPage extends StatelessWidget {
  const CancelledAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorAppointmentsCubit, DoctorAppointmentsState>(
      builder: (context, state) {
        if (state is DoctorAppointmentsLoading) {
          return const Center(child: CustomLoader(loaderSize: kLoaderSize));
        }

        if (state is DoctorAppointmentsError) {
          return Center(child: Text(state.message));
        }

        if (state is DoctorAppointmentsLoaded) {
          final appointments = state.appointments;
          if (appointments.isEmpty) {
            return const Center(child: Text('لا توجد حجوزات ملغاة'));
          }
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return DAppointmentCard(
                  patientName: appointment.patientInfo?.name ?? 'مريض',
                  patientImage: appointment.patientInfo?.profileImage ?? '',
                  time:
                      '${appointment.scheduleInfo?.startTime ?? ''} - ${appointment.scheduleInfo?.endTime ?? ''}',
                  date: appointment.date,
                  bookingNumber: '${appointment.id}',
                  location: appointment.cancellationReason ?? '',
                  showActions: false,
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
