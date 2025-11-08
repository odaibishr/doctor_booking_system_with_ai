import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'appointment_detail_row.dart';

class AppointmentDetailsContainer extends StatelessWidget {
  final String doctorName;
  final String operationNumber;
  final String date;
  final String period;
  final String price;

  const AppointmentDetailsContainer({
    super.key,
    required this.doctorName,
    required this.operationNumber,
    required this.date,
    required this.period,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray500, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات الحجز',
            style: FontStyles.subTitle2.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          AppointmentDetailRow(title: 'الدكتور', value: doctorName),
          const SizedBox(height: 12),
          AppointmentDetailRow(title: 'رقم العملية', value: operationNumber),
          const SizedBox(height: 12),
          AppointmentDetailRow(title: 'التاريخ', value: date),
          const SizedBox(height: 12),
          AppointmentDetailRow(title: 'الفترة', value: period),
          const SizedBox(height: 12),
          AppointmentDetailRow(title: 'السعر', value: price),
        ],
      ),
    );
  }
}
