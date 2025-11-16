import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/password_input_feild.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/title.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/logo.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordBody extends StatelessWidget {
  const CreateNewPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return CustomScrollView(
      slivers: [
        AppBar2(),
        SliverToBoxAdapter(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Logo(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  MainTitle(title: 'إنشاء كلمة مرور جديدة'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SubTitle(text: 'يجب أن تكون كلمة المرور الجديدة مختلفة كلمة المرور المستخدمة مسبقًا.',),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  PasswordField(
                    hintText: 'كلمة المرور',
                    validator: PasswordValidator,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  PasswordField(
                    hintText: 'كلمة المرور',
                    validator: PasswordValidator,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  MainButton(
                    text: 'إعادة تعيين كلمة المرور',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO:here the main Button !
                        GoRouter.of(
                          context,
                        ).pushReplacement(AppRouter.signInViewRoute);
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

  String? PasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال كلمة المرور ';
    }
    return null;
  }
}
