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
    // استخدام helper methods بدلاً من isDark في كل مكان
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
          color: AppColors.getGray100(context), // استخدام helper method
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
                color: AppColors.getGray400(context), // استخدام helper method
              ),
              child: _buildDoctorImage(context),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'د. ${topDoctor.name}',
                    style: FontStyles.subTitle3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.getTextPrimary(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                topDoctor.isFavorite == 1
                    ? Icon(Icons.favorite, color: AppColors.getError(context))
                    : Icon(
                        Icons.favorite_border_outlined,
                        color: AppColors.getGray500(context),
                      ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              topDoctor.specialty.name,
              style: FontStyles.body2.copyWith(
                color: AppColors.getGray500(context), // استخدام helper method
              ),
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
                      color: AppColors.getYellow(
                        context,
                      ), // استخدام helper method
                      size: 20,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '4.5',
                      style: FontStyles.body2.copyWith(
                        color: AppColors.getGray500(context),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${topDoctor.price} ريال',
                  style: FontStyles.body2.copyWith(
                    color: AppColors.getGray600(
                      context,
                    ), // استخدام helper method
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorImage(BuildContext context) {
    final image = topDoctor.profileImage.trim();
    if (image.isEmpty || image.toLowerCase() == 'null') {
      return Icon(Icons.person, color: AppColors.getPrimary(context));
    }

    return CachedNetworkImage(
      imageUrl: '${EndPoints.photoUrl}/$image',
      fit: BoxFit.contain,
      errorWidget: (context, url, error) =>
          Icon(Icons.person, color: AppColors.getPrimary(context)),
    );
  }
}
