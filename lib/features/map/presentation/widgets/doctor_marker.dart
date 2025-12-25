import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';

class DoctorMarker extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  const DoctorMarker({super.key, required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.location_on, color: AppColors.primary, size: 45),
          Positioned(
            top: 5,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
                border: Border.all(color: Colors.white, width: 2),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    '${EndPoints.photoUrl}/${doctor.profileImage}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
