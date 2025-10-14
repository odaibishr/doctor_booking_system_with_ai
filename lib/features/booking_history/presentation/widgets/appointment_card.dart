import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/location_info.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
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
                          Text(
                            '31 يوليو 2025 - 10 صباحاً',
                            style: FontStyles.body2.copyWith(
                              color: AppColors.gray500,
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
                      const SizedBox(height: 7),
                      Text(
                        'د. صادق محمد بشر',
                        style: FontStyles.subTitle3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      LocationInfo(
                        location: 'مستشفئ جامعة العلوم والتكنولوجيا',
                        color: AppColors.gray500,
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/card.svg'),
                          const SizedBox(width: 3),
                          Text(
                            'رقم الحجز: 1DE524248M',
                            style: FontStyles.body3.copyWith(
                              color: AppColors.gray500,
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MainButton(
                  text: 'حجز موعد',
                  onTap: () {},
                  height: 30,
                  radius: 6,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MainButton(
                  text: 'حجز موعد',
                  onTap: () {},
                  height: 30,
                  radius: 6,
                  color: AppColors.gray300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
