import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/doctor_card_horizontail.dart';

class SearchDoctorListView extends StatelessWidget {
  const SearchDoctorListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const DoctorCardHorizontail();
        },
      ),
    );
  }
}
