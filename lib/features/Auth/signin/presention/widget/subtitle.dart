import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Text(
        'سجّل دخولك الآن للوصول إلى مواعيدك الطبية وإدارة حجوزاتك بكل سهولة وأمان.',
        style: FontStyles.subTitle3.copyWith(
          color: AppColors.gray400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}