import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/vertical_doctor_card.dart';
import 'package:flutter/material.dart';

class RecommendedDoctorsWidget extends StatelessWidget {
  final List<Doctor> doctors;

  const RecommendedDoctorsWidget({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 16, right: 8, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'الأطباء المقترحين',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.whiteColor,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: doctors.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) =>
                  VerticalDoctorCard(topDoctor: doctors[index]),
            ),
          ),
        ],
      ),
    );
  }
}
