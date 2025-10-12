import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/rating.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/top_doctor.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class DoctorCardHorizontail extends StatelessWidget {
  const DoctorCardHorizontail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.1),
        //     offset: const Offset(0, 2),
        //     blurRadius: 5,
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 78,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.gray400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/images/doctor-image.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 7),
                      Text(
                        'د. صادق محمد بشر',
                        style: FontStyles.subTitle3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        'مخ واعصاب',
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
    );
  }
}
