import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class MedicalNotificationCard extends StatelessWidget {
  final String title;
  final String amount;
  final String description;
  final String number;
  final String date;

  const MedicalNotificationCard({
    super.key,
    required this.title,
    required this.amount,
    required this.description,
    required this.number,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: AppColors.primary,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: FontStyles.subTitle1.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                amount,
                style: FontStyles.subTitle2.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            description,
            style: FontStyles.body1.copyWith(
              color: AppColors.gray600,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            number,
            style: FontStyles.body2.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: SvgPicture.asset(
                  'assets/icons/calender.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),

                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                date,
                style: FontStyles.body2.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
