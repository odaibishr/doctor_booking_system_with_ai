import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/password_input_feild.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/widget/Diveder_custom.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/widget/forget_password_button.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/widget/google_auth_button.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/widget/logo.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/widget/subtitle.dart';
import 'package:flutter/material.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Logo(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  'تسجيل الدخول',
                  style: FontStyles.headLine4.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SubTitle(), //subtitle text
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                MainInputField(
                  hintText: 'الحساب الالكتروني',
                  leftIconPath: 'assets/icons/email.svg',
                  rightIconPath: 'assets/icons/email.svg',
                  isShowRightIcon: true,
                  isShowLeftIcon: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                PasswordField(hintText: 'كلمة المرور'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                //forget password button
                ForgetPasswordButton(text: 'نسيت كلمة المرور؟', ontap: () {}),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                MainButton(text: 'تسجيل الدخول', onTap: () {}), //main button
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                DividerCustom(), //divider line
                GoogleButton(onPressed: () {}),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  //Text for create account
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب؟',
                      style: FontStyles.body1.copyWith(
                        color: AppColors.gray400,
                      ),
                    ),
                    ForgetPasswordButton(text: 'إنشاء حساب', ontap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
