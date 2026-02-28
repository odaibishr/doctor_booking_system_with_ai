import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/appointment_action_buttons.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/patient_info_section.dart';
import 'package:flutter/material.dart';

class DAppointmentCard extends StatelessWidget {
  const DAppointmentCard({
    super.key,
    this.patientName = 'احمد مختار',
    this.patientImage = 'assets/images/profile_image.png',
    this.time = '8:00 - 10:00',
    this.date = '23 فبراير 2026',
    this.bookingNumber = '1024',
    this.location = 'مستشفى سيبلاس',
    this.isReturning = false,
    this.onConfirm,
    this.onReject,
  });

  final String patientName;
  final String patientImage;
  final String time;
  final String date;
  final String bookingNumber;
  final String location;
  final bool isReturning;
  final VoidCallback? onConfirm;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          PatientInfoSection(
            patientName: patientName,
            patientImage: patientImage,
            time: time,
            date: date,
            bookingNumber: bookingNumber,
            location: location,
            isReturning: isReturning,
          ),
          const SizedBox(height: 12),
          AppointmentActionButtons(
            onConfirm: onConfirm ?? () {},
            onReject: onReject ?? () {},
          ),
        ],
      ),
    );
  }
}
