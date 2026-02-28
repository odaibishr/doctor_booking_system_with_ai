import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/dappointment_card.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/appointments/doctor_appointments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PreviousAppointmentPage extends StatelessWidget {
  const PreviousAppointmentPage({super.key});

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
            return const Center(child: Text('لا توجد حجوزات سابقة'));
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
                  date: () {
                    try {
                      return DateFormat.yMMMMd(
                        'ar',
                      ).format(DateTime.parse(appointment.date));
                    } catch (_) {
                      return appointment.date;
                    }
                  }(),
                  bookingNumber: '${appointment.id}',
                  location: appointment.scheduleInfo?.dayName ?? '',
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
