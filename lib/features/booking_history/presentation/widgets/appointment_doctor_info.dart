import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/location_info.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class AppointmentDoctorInfo extends StatelessWidget {
  const AppointmentDoctorInfo({
    super.key,
    required this.doctorName,
    required this.location,
    required this.date,
    required this.bookingNumber,
    required this.doctorImage,
  });
  final String doctorName;
  final String location;
  final String date;
  final String bookingNumber;
  final String doctorImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 78,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.gray400,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(doctorImage, fit: BoxFit.contain),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: FontStyles.body2.copyWith(
                      color: AppColors.gray500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/heart-filled.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                doctorName,
                style: FontStyles.subTitle3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              LocationInfo(location: location, color: AppColors.gray500),
              const SizedBox(height: 7),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/card.svg'),
                  const SizedBox(width: 3),
                  Text(
                    bookingNumber,
                    style: FontStyles.body3.copyWith(color: AppColors.gray500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
