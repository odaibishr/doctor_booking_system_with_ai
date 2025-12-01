import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/location_info.dart';
import 'package:flutter/material.dart';

class HospitalHeaderSection extends StatelessWidget {
  const HospitalHeaderSection({
    super.key,
    required this.hospitalName,
    required this.hospitalLocation,
    required this.hospitalImage,
  });
  final String hospitalName;
  final String hospitalLocation;
  final String hospitalImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 189,
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(hospitalImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            hospitalName,
            style: FontStyles.subTitle3.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 6),
        LocationInfo(location: hospitalLocation, color: AppColors.gray500),
      ],
    );
  }
}
