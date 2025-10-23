import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/widget/logo.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:flutter/material.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

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
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              Logo(),
              Text(
                  'إنشاء حساب',
                  style: FontStyles.headLine4.copyWith(
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 12,),
              SubTitle(text: 'سجّل حسابك الآن واحجز مواعيدك الطبية بسهولة وفي أي وقت.'),
              MainInputField(
                  hintText: 'اسم المستخدم ',
                  leftIconPath: 'assets/icons/user.svg',
                  rightIconPath: 'assets/icons/user.svg',
                  isShowRightIcon: true,
                  isShowLeftIcon: false,
                ),

              


            ]),
          ),
        ),
      ],
    );
  }
}
