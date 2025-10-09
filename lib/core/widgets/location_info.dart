import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/location.svg',
          width: 10,
          height: 10,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(width: 5),
        Text(
          location,
          style: FontStyles.body3.copyWith(color: AppColors.gray100),
        ),
      ],
    );
  }
}