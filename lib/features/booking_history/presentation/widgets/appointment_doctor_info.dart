import 'package:cached_network_image/cached_network_image.dart';
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
    required this.isReturning,
  });
  final String doctorName;
  final String location;
  final String date;
  final String bookingNumber;
  final String doctorImage;
  final bool isReturning;

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
          clipBehavior: Clip.antiAlias,
          child: _buildDoctorImage(),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      date,
                      style: FontStyles.body2.copyWith(
                        color: AppColors.gray500,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildPatientTypeBadge(),
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

  Widget _buildDoctorImage() {
    if (doctorImage.isEmpty) {
      return const Icon(Icons.person, color: AppColors.primary, size: 32);
    }

    if (doctorImage.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: doctorImage,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: AppColors.error),
      );
    }

    return Image.asset(doctorImage, fit: BoxFit.contain);
  }

  Widget _buildPatientTypeBadge() {
    final color = isReturning ? Colors.blue : Colors.green;
    final text = isReturning ? 'عائد' : 'جديد';
    final icon = isReturning ? Icons.replay : Icons.person_add;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
