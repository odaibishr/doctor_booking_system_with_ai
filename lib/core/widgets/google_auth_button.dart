import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:social_auth_buttons/res/buttons/google_auth_button.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GoogleAuthButton(
        height: 45,
        text: 'تسجيل الدخول باستخدام ',
        onPressed: onPressed,
        textStyle: FontStyles.body1.copyWith(
          fontWeight: FontWeight.bold,
          color: context.blackColor,
        ),

        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2,
          vertical: 10,
        ),
        buttonColor: context.cardBackgroundColor,
        borderColor: context.gray300Color,
        borderWidth: 1,
        borderRadius: 12,
      ),
    );
  }
}
