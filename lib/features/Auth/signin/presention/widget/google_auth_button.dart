import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:social_auth_buttons/res/buttons/google_auth_button.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GoogleAuthButton(
        text:'تسجيل الدخول باستخدام ',
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        buttonColor: AppColors.white,
        borderColor: AppColors.gray300,
        borderWidth: 1,
        borderRadius: 12,
        //textStyle: TextStyle(fontFamily: 'materi', )
      ),
    );
  }
}

