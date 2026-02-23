import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/location_info.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class PatientInfoSection extends StatelessWidget {
  const PatientInfoSection({
    super.key,
    required this.patientName,
    required this.patientImage,
    required this.time,
    required this.date,
    required this.bookingNumber,
    required this.location,
    this.isReturning = false,
  });

  final String patientName;
  final String patientImage;
  final String time;
  final String date;
  final String bookingNumber;
  final String location;
  final bool isReturning;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 78,
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.gray200,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(patientImage, fit: BoxFit.cover),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      '$date - $time',
                      style: FontStyles.body2.copyWith(
                        color: AppColors.gray500,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isReturning) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'عودة',
                        style: FontStyles.body3.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 6),
              Text(
                patientName,
                style: FontStyles.subTitle3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              LocationInfo(location: location, color: AppColors.gray500),
              const SizedBox(height: 6),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/card.svg'),
                  const SizedBox(width: 3),
                  Text(
                    'رقم الحجز: $bookingNumber',
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
