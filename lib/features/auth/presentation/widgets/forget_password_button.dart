import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class ForgetPasswordButton extends StatelessWidget {
  final String text;
  const ForgetPasswordButton({
    super.key,
    required this.ontap,
    required this.text,
  });
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          style: FontStyles.body1.copyWith(
            color: context.primaryColor,
            decoration: TextDecoration.underline,
            decorationColor: context.primaryColor,
          ),
        ),
      ),
    );
  }
}
