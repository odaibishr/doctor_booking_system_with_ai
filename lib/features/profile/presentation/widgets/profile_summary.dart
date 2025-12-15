import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({
    super.key,
    required this.name,
    required this.userImage,
    required this.phoneNumber,
  });
  final String name;
  final String userImage;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundImage: NetworkImage('${EndPoints.photoUrl}/$userImage'),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: FontStyles.headLine4.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          phoneNumber,
          style: FontStyles.subTitle2.copyWith(color: AppColors.gray400),
        ),
      ],
    );
  }
}
