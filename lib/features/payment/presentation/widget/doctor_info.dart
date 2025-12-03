import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/location_info.dart';
import 'package:flutter/material.dart';

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    super.key,
    required this.name,
    required this.specialization,
    required this.location,
  });
  final String name;
  final String specialization;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: FontStyles.subTitle2.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 7),
        Text(
          specialization,
          style: FontStyles.subTitle3.copyWith(color: AppColors.gray500),
        ),
        const SizedBox(height: 7),
        LocationInfo(location: location, color: AppColors.gray500),
      ],
    );
  }
}
