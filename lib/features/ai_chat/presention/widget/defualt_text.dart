import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:flutter/material.dart';

class DefualtText extends StatelessWidget {
  const DefualtText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'مرحباُ بكم في تطبيق الحجوزات الطبية الذكي',
          style: FontStyles.subTitle2.copyWith(color: AppColors.gray400),
        ),
        SizedBox(height: 3),
        SubTitle(text: 'كيف يمكنني مساعدتكم اليوم؟'),
      ],
    );
  }
}
