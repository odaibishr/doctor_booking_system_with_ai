import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/password_input_feild.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/Diveder_custom.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/widget/forget_password_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/google_auth_button.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/widget/logo.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key:_formKey,
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
                  SubTitle(text: 'سجّل دخولك الآن للوصول إلى مواعيدك الطبية وإدارة حجوزاتك بكل سهولة وأمان.',), //subtitle text
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  MainInputField(
                    hintText: 'الحساب الالكتروني',
                    leftIconPath: 'assets/icons/email.svg',
                    rightIconPath: 'assets/icons/email.svg',
                    isShowRightIcon: true,
                    isShowLeftIcon: false,
                    validator: EmailValidator,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  PasswordField(hintText: 'كلمة المرور',
                    validator: PasswordValidator,
                  ),
                  const SizedBox(height: 17),
                  //forget password button
                  ForgetPasswordButton(text: 'نسيت كلمة المرور؟', ontap: () {}),
                  const SizedBox(height: 23.5),
                  MainButton(
                    text: 'تسجيل الدخول',
                    onTap: () {
                      if(_formKey.currentState!.validate())
                      {
                          GoRouter.of(context,).pushReplacement(AppRouter.appNavigationRoute);
                      }
                    
                    },
                  ), //main button
                  const SizedBox(height: 23.5),
                  DividerCustom(), //divider line
                  const SizedBox(height: 18.5),
                  GoogleButton(onPressed: () {}),
                  const SizedBox(height: 23.5),
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
                      ForgetPasswordButton(text: 'إنشاء حساب', ontap: () {
                        GoRouter.of(context).push(AppRouter.signupViewRoute);
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String? PasswordValidator(value){
                    if(value == null || value.isEmpty){
                      return 'الرجاء ادخال كلمة المرور ';
                    }
                    return null;
                  }

  String? EmailValidator(value){
                    if(value == null || value.isEmpty){
                      return 'الرجاء ادخال البريد الالكتروني ';
                    }
                    else if(!value.contains('@')){
                      return 'الرجاء ادخال بريد الكتروني صحيح ';
                    }
                    return null;
                  }
}
