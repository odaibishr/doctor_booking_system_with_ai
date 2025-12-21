// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/location_info.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/price_lable_with_icon.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

class DoctorFeaturedBanner extends StatelessWidget {
  const DoctorFeaturedBanner({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final image = doctor.profileImage.trim();
    final hasValidImage = image.isNotEmpty && image.toLowerCase() != 'null';
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.detailsViewRoute, extra: doctor.id);
      },
      child: Container(
        width: Responsive.isDesktop(context)
            ? 800
            : MediaQuery.of(context).size.width * 0.9,
        height: Responsive.isDesktop(context) ? 250 : 162,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Info Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doctor.specialty.name,
                    style: FontStyles.subTitle3.copyWith(
                      color: AppColors.gray100,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'د/ ${doctor.name}',
                    style: FontStyles.headLine4.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Responsive.isDesktop(context)
                        ? 400
                        : MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      doctor.services.replaceAll('.', ' و'),
                      style: FontStyles.body3.copyWith(
                        color: AppColors.gray100,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LocationInfo(
                    location: doctor.location.name,
                    color: AppColors.gray300,
                  ),
                  const SizedBox(height: 5),
                  PriceLableWithIcon(price: doctor.price),
                ],
              ),
            ),
            // Image
            hasValidImage
                ? CachedNetworkImage(
                    imageUrl: '${EndPoints.photoUrl}/$image',
                    width: Responsive.isDesktop(context) ? 150 : 100,
                    height: double.infinity,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person, color: Colors.white),
                  )
                : const Icon(Icons.person, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
