import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/google_auth_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/password_input_feild.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/Diveder_custom.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/title.dart';

import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/custom_appbar.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/end_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/logo.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return CustomScrollView(
      slivers: [
        AppBar2(), //this is AppBar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  GoRouter.of(
                    context,
                  ).pushReplacement(AppRouter.appNavigationRoute);
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(child: CircularProgressIndicator()),
                    ],
                  );
                }
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Logo(), //LOgo
                      MainTitle(title: 'سجّل حسابك الآن'), //main title
                      SizedBox(height: 12),
                      SubTitle(
                        text:
                            'سجّل حسابك الآن واحجز مواعيدك الطبية بسهولة وفي أي وقت.',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      MainInputField(
                        //User Name textfield
                        hintText: 'اسم المستخدم ',
                        leftIconPath: 'assets/icons/user.svg',
                        rightIconPath: 'assets/icons/user.svg',
                        isShowRightIcon: true,
                        isShowLeftIcon: false,
                        controller: nameController,
                        validator: nameValidator,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      MainInputField(
                        //Email textfield
                        hintText: 'البريد الالكتروني',
                        leftIconPath: 'assets/icons/email.svg',
                        rightIconPath: 'assets/icons/user.svg',
                        isShowRightIcon: true,
                        isShowLeftIcon: false,
                        controller: emailController,
                        validator: emailValidator,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      PasswordField(
                        //Password textfield
                        hintText: 'كلمة المرور',
                        controller: passwordController,
                        validator: passwordValidator,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      PasswordField(
                        //Confirm Password textfield
                        hintText: 'تأكيد كلمة المرور',
                        controller: confirmPasswordController,
                        validator: confirmPasswordValidator,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      MainButton(
                        text: 'انشاء حساب',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).signUp(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              passwordConfirmation:
                                  confirmPasswordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      DividerCustom(),
                      GoogleButton(onPressed: () {}), //Google Button
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      EndSection(), //End Section of the page
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  //here the Valdiation Messages of TextFeilds !
  String? confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء تأكيد كلمة المرور ';
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور ';
    }
    return null;
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الالكتروني ';
    } else if (!value.contains('@')) {
      return 'الرجاء إدخال بريد الكتروني صالح ';
    }
    return null;
  }

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال اسم المستخدم';
    }
    return null;
  }
}
