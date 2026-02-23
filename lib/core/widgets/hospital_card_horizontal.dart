import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HospitalCardHorizontal extends StatelessWidget {
  const HospitalCardHorizontal({super.key, required this.hospital});
  final Hospital hospital;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push(AppRouter.hospitalDetailsViewRoute, extra: hospital.id);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.getGray100(context),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.getGray400(context).withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.getGray400(context),
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: _buildHospitalImage(context),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospital.name,
                    style: FontStyles.subTitle3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.getTextPrimary(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.getGray500(context),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          hospital.address,
                          style: FontStyles.body3.copyWith(
                            color: AppColors.getGray500(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: AppColors.getGray500(context),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        hospital.phone,
                        style: FontStyles.body3.copyWith(
                          color: AppColors.getGray500(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Rating(rating: 4.5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.getPrimary(context).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'عرض التفاصيل',
                          style: FontStyles.body4.copyWith(
                            color: AppColors.getPrimary(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalImage(BuildContext context) {
    final image = hospital.image.trim();
    if (image.isEmpty || image.toLowerCase() == 'null') {
      return Center(
        child: Icon(
          Icons.local_hospital,
          color: AppColors.getPrimary(context),
          size: 40,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: '${EndPoints.photoUrl}/$image',
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Center(
        child: Icon(
          Icons.local_hospital,
          color: AppColors.getPrimary(context),
          size: 40,
        ),
      ),
    );
  }
}
