import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/forget_password_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EndSection extends StatelessWidget {
  const EndSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      //Text for create account
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'هل لديك حساب ؟  ',
          style: FontStyles.body1.copyWith(color: AppColors.gray400),
        ),
        ForgetPasswordButton(
          text: ' تسجيل الدخول',
          ontap: () {
            GoRouter.of(context).push(AppRouter.signInViewRoute);
          },
        ),
      ],
    );
  }
}
