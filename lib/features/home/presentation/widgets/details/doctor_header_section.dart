import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class DoctorHeaderSection extends StatelessWidget {
  const DoctorHeaderSection({
    super.key,
    required this.doctorName,
    required this.doctorSpecializatioin,
    required this.doctorLocation,
    required this.doctorImage,
  });
  final String doctorName;
  final String doctorSpecializatioin;
  final String doctorLocation;
  final String doctorImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 190,
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            bottom: 0,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(doctorImage, fit: BoxFit.contain),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            Row(
              children: [
                Text(
                  doctorName,
                  style: FontStyles.subTitle1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  doctorSpecializatioin,
                  style: FontStyles.subTitle2.copyWith(
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/location.svg",
                  width: 14,
                  height: 14,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    AppColors.gray500,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  doctorLocation,
                  style: FontStyles.body2.copyWith(color: AppColors.gray500),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
