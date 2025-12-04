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
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.detailsViewRoute);
      },
      child: Container(
        width: double.infinity,
        height: 165,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.gray100,
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
                      color: AppColors.gray400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '${EndPoints.photoUrl}/${doctor.profileImage}',
                      fit: BoxFit.fill,
                    ),
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
                                'assets/icons/heart-filled.svg',
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
                            ),
                          ),
                        const SizedBox(height: 7),
                        Text(
                          doctor.specialty.name,
                          style: FontStyles.body2.copyWith(
                            color: AppColors.gray500,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Rating(rating: 4.5),
                              Text(
                                '5000 ريال',
                                style: FontStyles.body2.copyWith(
                                  fontWeight: FontWeight.bold,
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
            MainButton(text: 'حجز موعد', onTap: () {}, height: 30),
          ],
        ),
      ),
    );
  }
}
