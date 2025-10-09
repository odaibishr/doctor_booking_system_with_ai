import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/vertical_doctor_card.dart';
import 'package:flutter/material.dart';

class DoctorCardListView extends StatelessWidget {
  const DoctorCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: const VerticalDoctorCard(),
          );
        },
      ),
    );
  }
}
