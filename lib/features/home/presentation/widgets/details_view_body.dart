import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/location_info.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          CustomAppBar(
            userImage: 'assets/images/user.png',
            title: 'معلومات الطبيب',
            isBackButtonVisible: true,
            isUserImageVisible: false,
            isHeartIconVisible: true,
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            height: 190,
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              bottom: 0,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/images/doctor-image.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'د. صادق محمد بشر',
                    style: FontStyles.subTitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'مخ واعصاب',
                    style: FontStyles.subTitle2.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/location.svg",
                    width: 14,
                    height: 14,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                      AppColors.gray500,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'مستشفئ جامعة العلوم والتكنولوجيا',
                    style: FontStyles.body2.copyWith(color: AppColors.gray500),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
