import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/vertical_doctor_card.dart';
import 'package:flutter/material.dart';

class DoctorCardListView extends StatelessWidget {
  const DoctorCardListView({super.key, required this.topOfDoctors});
  final List<Doctor> topOfDoctors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topOfDoctors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: VerticalDoctorCard(topDoctor: topOfDoctors[index]),
          );
        },
      ),
    );
  }
}
