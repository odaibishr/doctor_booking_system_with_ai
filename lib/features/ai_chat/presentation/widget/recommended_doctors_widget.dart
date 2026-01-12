import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/doctor_card_horizontail.dart';
import 'package:flutter/material.dart';

class RecommendedDoctorsWidget extends StatelessWidget {
  final List<Doctor> doctors;

  const RecommendedDoctorsWidget({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 16, right: 8, left: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.primaryColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: context.primaryColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'الاطباء المقترحين',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.whiteColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: doctors.length,
            itemBuilder: (context, index) =>
                _ChatDoctorCard(doctor: doctors[index]),
          ),
        ],
      ),
    );
  }
}

class _ChatDoctorCard extends StatelessWidget {
  final Doctor doctor;

  const _ChatDoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return DoctorCardHorizontail(doctor: doctor);
  }
}
