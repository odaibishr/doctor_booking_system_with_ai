import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/utils/responsive.dart';

import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/doctor_card_horizontail.dart';

class SearchDoctorListView extends StatelessWidget {
  const SearchDoctorListView({super.key, required this.doctors});
  final List<Doctor> doctors;

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isMobile(context)) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
          mainAxisExtent: 190,
          crossAxisSpacing: 16,
          mainAxisSpacing: 0,
        ),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCardHorizontail(doctor: doctors[index]);
        },
      );
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return DoctorCardHorizontail(doctor: doctors[index]);
      },
    );
  }
}
