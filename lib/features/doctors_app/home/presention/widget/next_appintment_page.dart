import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/dappointment_card.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/appointments/doctor_appointments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NextAppintmentPage extends StatelessWidget {
  const NextAppintmentPage({super.key});

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
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<DoctorAppointmentsCubit>()
                  .fetchAppointmentsByStatus('confirmed');
            },
            child: appointments.isEmpty
                ? const Center(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Text('لا توجد حجوزات قادمة'),
                  ),
                )
                : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16, left: 14, right: 14),
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    final formattedDate = _formatDate(appointment.date);
                    return DAppointmentCard(
                      patientName: appointment.patientInfo?.name ?? 'مريض',
                      patientImage: appointment.patientInfo?.profileImage ?? '',
                      time:
                          '${appointment.scheduleInfo?.startTime ?? ''} - ${appointment.scheduleInfo?.endTime ?? ''}',
                      date: formattedDate,
                      bookingNumber: '${appointment.id}',
                      isNew: false,
                      cardType: AppointmentCardType.confirmed,
                    );
                  },
                ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  String _formatDate(String rawDate) {
    try {
      final parsed = DateTime.parse(rawDate);
      return DateFormat('EEEE، d MMMM yyyy', 'ar').format(parsed);
    } catch (_) {
      return rawDate;
    }
  }

}
