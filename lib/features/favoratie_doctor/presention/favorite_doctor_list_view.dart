import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/doctor_card_horizontail.dart';
import 'package:flutter/material.dart';

class FavoriteDoctorListView extends StatelessWidget {
  const FavoriteDoctorListView({super.key, required this.doctors});
  final List<Doctor> doctors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCardHorizontail(doctor: doctors[index]);
        },
      ),
    );
  }
}
