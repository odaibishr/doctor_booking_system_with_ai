import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/rating.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/top_doctor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';

class DoctorCardHorizontail extends StatelessWidget {
  const DoctorCardHorizontail({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.cardDark : AppColors.gray100;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.black;
    final secondaryTextColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.gray500;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final imageBackgroundColor = isDark
        ? AppColors.gray400Dark
        : AppColors.gray400;

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.detailsViewRoute, extra: doctor.id);
      },
      child: Container(
        width: double.infinity,
        height: 165,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: imageBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _buildDoctorImage(primaryColor),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (doctor.isTopDoctor == 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TopDoctor(),
                              SvgPicture.asset(
                                doctor.isFavorite == 1
                                    ? 'assets/icons/heart-filled.svg'
                                    : 'assets/icons/heart-unfilled.svg',
                                width: 24,
                                height: 24,
                                fit: BoxFit.scaleDown,
                              ),
                            ],
                          ),
                        if (doctor.isTopDoctor == 0) const SizedBox(height: 7),
                        const SizedBox(height: 7),
                        if (doctor.isTopDoctor == 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'د. ${doctor.name}',
                                style: FontStyles.subTitle3.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
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
                        if (doctor.isTopDoctor == 1)
                          Text(
                            'د. ${doctor.name}',
                            style: FontStyles.subTitle3.copyWith(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        const SizedBox(height: 7),
                        Text(
                          doctor.specialty.name,
                          style: FontStyles.body2.copyWith(
                            color: secondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Rating(rating: 4.5),
                              Text(
                                '${doctor.price} ريال',
                                style: FontStyles.body2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            MainButton(
              text: 'حجز موعد',
              onTap: () {
                GoRouter.of(
                  context,
                ).push(AppRouter.appointmentViewRoute, extra: doctor);
              },
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorImage(Color primaryColor) {
    final image = doctor.profileImage.trim();
    if (image.isEmpty || image.toLowerCase() == 'null') {
      return Icon(Icons.person, color: primaryColor);
    }

    return CachedNetworkImage(
      imageUrl: '${EndPoints.photoUrl}/$image',
      fit: BoxFit.fill,
      errorWidget: (context, url, error) =>
          Icon(Icons.person, color: primaryColor),
    );
  }
}
