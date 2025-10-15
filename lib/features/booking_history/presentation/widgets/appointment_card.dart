import 'package:flutter/material.dart';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/appointment_card_factory.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/appointment_doctor_info.dart';

enum AppointmentStatus { upcoming, completed, cancelled }

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.textButton1,
    required this.textButton2,
    required this.status,
  });

  final String textButton1;
  final String textButton2;
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: AppointmentDoctorInfo(
              doctorName: 'د. صادق محمد بشر',
              location: 'القاهرة',
              date: '31 يوليو 2025 - 10 صباحاً',
              bookingNumber: 'رقم الحجز: 1DE524248M',
              doctorImage: 'assets/images/doctor-image.png',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: AppointmentCardFactory.getButtons(
              context: context,
              status: status,
              textButton1: textButton1,
              textButton2: textButton2,
            ),
          ),
        ],
      ),
    );
  }
}
