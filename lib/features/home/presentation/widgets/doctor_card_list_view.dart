import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/animated_widgets.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/vertical_doctor_card.dart';
import 'package:doctor_booking_system_with_ai/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class DoctorCardListView extends StatelessWidget {
  const DoctorCardListView({super.key, required this.topOfDoctors});
  final List<Doctor> topOfDoctors;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return SizedBox(
      height: isDesktop ? 260 : 205,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topOfDoctors.length,
        itemBuilder: (context, index) {
          return AnimatedListItem(
            index: index,
            delay: const Duration(milliseconds: 80),
            animationType: AnimationType.fadeSlideRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: VerticalDoctorCard(
                topDoctor: topOfDoctors[index],
                width: isDesktop ? 250 : 205,
                height: isDesktop ? 250 : 205,
              ),
            ),
          );
        },
      ),
    );
  }
}
