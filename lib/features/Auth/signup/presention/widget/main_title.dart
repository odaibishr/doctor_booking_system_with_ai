import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'إنشاء حساب',
      style: FontStyles.headLine4.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

