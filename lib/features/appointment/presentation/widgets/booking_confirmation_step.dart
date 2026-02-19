import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/appointment_details.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/doctor_info.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/jaib_show_dialog.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingConfirmationStep extends StatelessWidget {
  final Doctor doctor;
  final DateTime selectedDate;
  final String selectedTime;

  const BookingConfirmationStep({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DoctorInfo(
          name: 'د. ${doctor.name}',
          specialization: doctor.specialty.name,
          location: doctor.location.name,
        ),
        const SizedBox(height: 20),
        Text(
          'طريقة الدفع',
          style: FontStyles.subTitle2.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        PaymentMethodItem(
          label: '',
          iconPath: 'assets/images/jaib.svg',
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => const JaibShowDialog(),
            );
          },
        ),
        const SizedBox(height: 20),
        AppointmentDetails(
          doctorName: doctor.name,
          date: DateFormat.yMMMMd('ar').format(selectedDate),
          time: selectedTime,
          price: doctor.price,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
