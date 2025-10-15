import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/location_info.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/price_lable_with_icon.dart';
import 'package:flutter/material.dart';

class DoctorFeaturedBanner extends StatelessWidget {
  const DoctorFeaturedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 162,
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
                    'مخ واعصاب',
                    style: FontStyles.subTitle3.copyWith(
                      color: AppColors.gray100,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'د/ صادق محمد بشر',
                    style: FontStyles.headLine4.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      'متخصص في علاج ومتابعة أمراض الصرع وعلاج أمراض المخ والأعصاب',
                      style: FontStyles.body3.copyWith(
                        color: AppColors.gray100,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const LocationInfo(
                    location: 'مستشفئ جامعة العلوم والتكنولوجيا',
                    color: AppColors.gray300,
                  ),
                  const SizedBox(height: 5),
                  const PriceLableWithIcon(price: 5000),
                ],
              ),
            ),
            // Image
            Image.asset(
              'assets/images/doctor-image.png',
              width: 100,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
