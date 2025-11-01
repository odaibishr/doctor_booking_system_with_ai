import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/title.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/widget/logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailInputBody extends StatelessWidget {
  const EmailInputBody({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey();
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Logo(),
                  MainTitle(title: 'نسيت كملة المرور'),
                  SizedBox(height: 14),
                  SubTitle(
                    text: 'أدخل بريدك الإلكتروني و سنرسل لك رمز التحقق.',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  MainInputField(
                    hintText: 'الحساب الالكتروني',
                    leftIconPath: 'assets/icons/email.svg',
                    rightIconPath: 'assets/icons/email.svg',
                    isShowRightIcon: true,
                    isShowLeftIcon: false,
                    validator: EmailValidator,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  MainButton(
                    text: 'إرسال الرمز',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO:here the main Button !
                        GoRouter.of(context).push(AppRouter.verfiycodeViewRout);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String? EmailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال البريد الالكتروني ';
    } else if (!value.contains('@')) {
      return 'الرجاء ادخال بريد الكتروني صحيح ';
    }
    return null;
  }
}
