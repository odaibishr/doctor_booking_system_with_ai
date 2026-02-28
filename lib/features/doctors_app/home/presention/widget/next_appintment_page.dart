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
          if (appointments.isEmpty) {
            return const Center(child: Text('لا توجد حجوزات قادمة'));
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
                  showActions: true,
                  onConfirm: () {
                    context
                        .read<DoctorAppointmentsCubit>()
                        .updateAppointmentStatus(
                          id: appointment.id,
                          status: 'confirmed',
                        );
                  },
                  onReject: () => _showCancelDialog(context, appointment.id),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _showCancelDialog(BuildContext context, int appointmentId) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('سبب الإلغاء'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'أدخل سبب الإلغاء'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<DoctorAppointmentsCubit>().updateAppointmentStatus(
                id: appointmentId,
                status: 'cancelled',
                cancellationReason: controller.text,
              );
            },
            child: const Text('تأكيد الإلغاء'),
          ),
        ],
      ),
    );
  }
}
