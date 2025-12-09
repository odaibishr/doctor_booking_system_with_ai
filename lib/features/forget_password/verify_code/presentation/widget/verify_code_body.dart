import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/title.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/forget_password_button.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/logo.dart';
import 'package:doctor_booking_system_with_ai/features/forget_password/verify_code/presentation/widget/verify_code_digits.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyCodeBody extends StatefulWidget {
  const VerifyCodeBody({super.key});

  @override
  State<VerifyCodeBody> createState() => _VerifyCodeBodyState();
}

class _VerifyCodeBodyState extends State<VerifyCodeBody> {
  String otpCode = ''; //TODO this var have the value od digits
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: CustomAppBar(
            title: '',
            isBackButtonVisible: true,
            isUserImageVisible: false,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                Logo(),
                MainTitle(title: 'التأكد من رمز التحقق'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                SubTitle(
                  text:
                      'أدخل الرمز الذي أرسلناه لك للتو على بريدك الإلكتروني المسجل',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: AnimatedOtpInput(
                    length: 5, // عدد الخانات
                    onCompleted: (value) {
                      setState(() {
                        otpCode =
                            value; //TODO this var have the value od digits
                      });
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                MainButton(
                  text: 'تأكيد',
                  onTap: () {
                    if (otpCode.length == 5) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('تم إدخال الرمز')));
                      GoRouter.of(
                        context,
                      ).push(AppRouter.createNewPasswordViewRoute);
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  //Text for create account
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لم تحصل على الرمز ؟  ',
                      style: FontStyles.body1.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                    ForgetPasswordButton(
                      text: 'إعادة الإرسال ',
                      ontap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('اعادة ارسال الرمز')),
                        );
                      },
                    ),
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
