import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 221,
      height: 180,
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
            clipBehavior: Clip.antiAlias,
            child: Image.asset('assets/images/hospital.jpg', fit: BoxFit.fill),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: 200,
            child: Text(
              'مستشفى جامعة العلوم والتكنولوجيا',
              style: FontStyles.body3.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: AppColors.gray500, size: 10),
              const SizedBox(width: 2),
              Text(
                'صنعاء . شارع الستين . جسر مذبح',
                style: FontStyles.body4.copyWith(color: AppColors.gray500),
              ),
            ],
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
                    size: 15,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '4.5',
                    style: FontStyles.body3.copyWith(color: AppColors.gray500),
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
