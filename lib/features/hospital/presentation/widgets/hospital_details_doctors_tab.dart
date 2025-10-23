import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/doctor_card_horizontail.dart';

class HospitalDetailsDoctorsTab extends StatelessWidget {
  final List<Map<String, dynamic>> doctors;

  const HospitalDetailsDoctorsTab({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: doctors.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return DoctorCardHorizontail();
      },
    );
  }
}
