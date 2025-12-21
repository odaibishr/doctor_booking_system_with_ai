import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({
    super.key,
    required this.hospital,
    this.width = 221,
    this.height = 180,
  });
  final Hospital hospital;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push(AppRouter.hospitalDetailsViewRoute, extra: hospital.id);
      },
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.gray400,
              ),
              clipBehavior: Clip.antiAlias,
              child: _buildHospitalImage(),
            ),

            const SizedBox(height: 12),

            Text(
              hospital.name,
              style: FontStyles.body3.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: AppColors.gray500, size: 10),
                const SizedBox(width: 2),
                Text(
                  hospital.address,
                  style: FontStyles.body4.copyWith(color: AppColors.gray500),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: const Color.fromARGB(255, 219, 206, 86),
                      size: 15,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '4.5',
                      style: FontStyles.body3.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalImage() {
    final image = hospital.image.trim();
    if (image.isEmpty || image.toLowerCase() == 'null') {
      return const Icon(Icons.local_hospital, color: AppColors.primary);
    }

    return CachedNetworkImage(
      imageUrl: '${EndPoints.photoUrl}/$image',
      fit: BoxFit.cover,
      errorWidget: (context, url, error) =>
          const Icon(Icons.local_hospital, color: AppColors.primary),
    );
  }
}
