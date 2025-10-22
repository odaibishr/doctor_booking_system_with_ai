import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/password_input_feild.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

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
                Image.asset(
                  'assets/icons/logo-transparent.png',
                  width: 180,
                  height: 180,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text('تسجيل الدخول', style: FontStyles.headLine4),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'سجّل دخولك الآن للوصول إلى مواعيدك الطبية وإدارة حجوزاتك بكل سهولة وأمان.',
                    style: FontStyles.subTitle3.copyWith(
                      color: AppColors.gray400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                MainInputField(
                  hintText: 'الحساب الالكتروني',
                  leftIconPath: 'assets/icons/email.svg',
                  rightIconPath: 'assets/icons/email.svg',
                  isShowRightIcon: true,
                  isShowLeftIcon: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                PasswordField(hintText: 'كلمة المرور',),
                Text('نسيت كلمة المرور؟')

                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
