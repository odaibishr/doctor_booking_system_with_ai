import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class VerticalDoctorCard extends StatelessWidget {
  const VerticalDoctorCard({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      height: 205,
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
            child: Image.asset(
              'assets/images/doctor-image.png',
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'د. صادق محمد بشر',
                style: FontStyles.subTitle3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.favorite, color: AppColors.error),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "مخ واعصاب",
            style: FontStyles.body2.copyWith(color: AppColors.gray500),
          ),
          const SizedBox(height: 6),
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
                    style: FontStyles.body2.copyWith(color: AppColors.gray500),
                  ),
                ],
              ),
              // PriceLableWithIcon(price: 5000),
              Text(
                '5000 ريال',
                style: FontStyles.body2.copyWith(color: AppColors.gray600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
