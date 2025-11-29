import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/password_input_feild.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/diveder_custom.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/forget_password_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/google_auth_button.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/logo.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  return const CustomLoader(loaderSize: kLoaderSize);
                }
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Logo(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'تسجيل الدخول',
                        style: FontStyles.headLine4.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      SubTitle(
                        text:
                            'سجّل دخولك الآن للوصول إلى مواعيدك الطبية وإدارة حجوزاتك بكل سهولة وأمان.',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      MainInputField(
                        hintText: 'الحساب الالكتروني',
                        leftIconPath: 'assets/icons/email.svg',
                        rightIconPath: 'assets/icons/email.svg',
                        isShowRightIcon: true,
                        isShowLeftIcon: false,
                        validator: emailValidator,
                        controller: emailController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      PasswordField(
                        hintText: 'كلمة المرور',
                        validator: passwordValidator,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 17),

                      ForgetPasswordButton(
                        text: 'نسيت كلمة المرور؟',
                        ontap: () {
                          GoRouter.of(
                            context,
                          ).push(AppRouter.emailinputViewRoute);
                        },
                      ),
                      const SizedBox(height: 23.5),
                      MainButton(
                        text: 'تسجيل الدخول',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().signIn(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 23.5),
                      DividerCustom(),
                      const SizedBox(height: 18.5),
                      GoogleButton(onPressed: () {}),
                      const SizedBox(height: 23.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لديك حساب؟',
                            style: FontStyles.body1.copyWith(
                              color: AppColors.gray400,
                            ),
                          ),
                          ForgetPasswordButton(
                            text: 'إنشاء حساب',
                            ontap: () {
                              GoRouter.of(
                                context,
                              ).push(AppRouter.signupViewRoute);
                            },
                          ),
                        ],
                      ),
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

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال كلمة المرور ';
    }
    return null;
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال البريد الالكتروني ';
    } else if (!value.contains('@')) {
      return 'الرجاء ادخال بريد الكتروني صحيح ';
    }
    return null;
  }
}
