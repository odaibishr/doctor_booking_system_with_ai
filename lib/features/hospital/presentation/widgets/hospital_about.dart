import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/animated_widgets.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_header_section.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_stats_section.dart';
import 'package:flutter/material.dart';

class HospitalAbout extends StatelessWidget {
  const HospitalAbout({super.key, required this.hospital});
  final Hospital hospital;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedEntrance(
          delay: const Duration(milliseconds: 100),
          animationType: AnimationType.fadeScale,
          child: HospitalHeaderSection(
            hospitalName: hospital.name,
            hospitalLocation: hospital.address,
            hospitalImage: hospital.image,
          ),
        ),
        const SizedBox(height: 20),
        // Stats Section with animation
        AnimatedEntrance(
          delay: const Duration(milliseconds: 200),
          animationType: AnimationType.fadeSlideUp,
          child: HospitalStatsSection(hospital: hospital),
        ),
      ],
    );
  }
}
