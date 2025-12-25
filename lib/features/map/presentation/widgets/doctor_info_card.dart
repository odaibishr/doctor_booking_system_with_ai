import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';

class DoctorInfoCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorInfoCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: AppColors.primary,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: '${EndPoints.photoUrl}/${doctor.profileImage}',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.person, size: 40, color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    doctor.specialty.name,
                    style: TextStyle(color: AppColors.white),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        "4.8 (120 reviews)", // Placeholder for real rating
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // Navigate to doctor details
                context.push(AppRouter.detailsViewRoute, extra: doctor.id);
              },
              icon: Icon(Icons.arrow_forward_ios, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
