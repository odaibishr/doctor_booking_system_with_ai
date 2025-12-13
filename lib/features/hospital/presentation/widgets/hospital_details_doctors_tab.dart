import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/doctor_card_horizontail.dart';
import 'package:flutter/material.dart';

class HospitalDetailsDoctorsTab extends StatelessWidget {
  final List<Doctor> doctors;

  const HospitalDetailsDoctorsTab({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: doctors.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return DoctorCardHorizontail(doctor: doctors[index]);
      },
    );
  }
}
