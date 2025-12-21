import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerticalDoctorCard extends StatelessWidget {
  const VerticalDoctorCard({
    super.key,
    required this.topDoctor,
    this.width = 205,
    this.height = 205,
  });
  final Doctor topDoctor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push(AppRouter.detailsViewRoute, extra: topDoctor.id);
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
              child: _buildDoctorImage(),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'د. ${topDoctor.name}',
                  style: FontStyles.subTitle3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                topDoctor.isFavorite == 1
                    ? Icon(Icons.favorite, color: AppColors.error)
                    : Icon(
                        Icons.favorite_border_outlined,
                        color: AppColors.gray500,
                      ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              topDoctor.specialty.name,
              style: FontStyles.body2.copyWith(color: AppColors.gray500),
            ),
            const SizedBox(height: 9),
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
                      size: 20,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '4.5',
                      style: FontStyles.body2.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
                // PriceLableWithIcon(price: 5000),
                Text(
                  '${topDoctor.price} ريال',
                  style: FontStyles.body2.copyWith(color: AppColors.gray600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorImage() {
    final image = topDoctor.profileImage.trim();
    if (image.isEmpty || image.toLowerCase() == 'null') {
      return const Icon(Icons.person, color: AppColors.primary);
    }

    return CachedNetworkImage(
      imageUrl: '${EndPoints.photoUrl}/$image',
      fit: BoxFit.contain,
      errorWidget: (context, url, error) =>
          const Icon(Icons.person, color: AppColors.primary),
    );
  }
}
