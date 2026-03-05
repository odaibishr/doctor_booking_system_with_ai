import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/password_input_feild.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/diveder_custom.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/forget_password_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/google_auth_button.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/logo.dart';
import 'package:doctor_booking_system_with_ai/core/manager/profile/profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/user_doctor_chooice.dart';
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
  int selectedIndex = 0;

  bool get _isDoctor => selectedIndex == 1;

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
                  context.read<ProfileCubit>().getProfile();
                  final user = state.user;

                  if (user.role == 'doctor') {
                    GoRouter.of(
                      context,
                    ).pushReplacement(AppRouter.customNavigationBarRoute);
                  } else {
                    if (user.phone == null ||
                        user.phone!.isEmpty ||
                        user.gender == null ||
                        user.gender!.isEmpty) {
                      GoRouter.of(
                        context,
                      ).pushReplacement(AppRouter.createprofileViewRout);
                    } else {
                      GoRouter.of(
                        context,
                      ).pushReplacement(AppRouter.appNavigationRoute);
                    }
                  }
                } else if (state is AuthError) {
                  context.showErrorToast(state.message);
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
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Logo(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        'تسجيل الدخول',
                        style: FontStyles.headLine4.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SubTitle(
                        text:
                            'سجّل دخولك الآن للوصول إلى مواعيدك الطبية وإدارة حجوزاتك بكل سهولة .',
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          user_doctor_chooice(
                            index: 0,
                            selectedIndex: selectedIndex,
                            title: 'مريض',
                            imageheight: 40,
                            imageWidth: 40,
                            image: 'assets/icons/userf.svg',
                            onTapFun: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                          ),
                          SizedBox(width: 30),
                          user_doctor_chooice(
                            index: 1,
                            selectedIndex: selectedIndex,
                            title: 'طبيب',
                            imageheight: 42,
                            imageWidth: 42,
                            image: 'assets/icons/doctor.svg',
                            onTapFun: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      MainInputField(
                        hintText: 'الحساب الالكتروني',
                        leftIconPath: 'assets/icons/email.svg',
                        rightIconPath: 'assets/icons/email.svg',
                        isShowRightIcon: true,
                        isShowLeftIcon: false,
                        validator: emailValidator,
                        controller: emailController,
                        border: context.primaryColor,
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
                      const SizedBox(height: 20),
                      MainButton(
                        text: 'تسجيل الدخول',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final token = context.read<AuthCubit>().fcmToken;
                            context.read<AuthCubit>().signIn(
                              email: emailController.text,
                              password: passwordController.text,
                              fcm_token: token,
                            );
                          }
                        },
                      ),
                      if (!_isDoctor) ...[
                        const SizedBox(height: 15),
                        DividerCustom(),
                        const SizedBox(height: 10),
                        GoogleButton(
                          onPressed: () {
                            context.read<AuthCubit>().signInWithGoogle();
                          },
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ليس لديك حساب؟',
                              style: FontStyles.body1.copyWith(
                                color: context.gray400Color,
                              ),
                            ),
                            ForgetPasswordButton(
                              text: 'نشاء حساب',
                              ontap: () {
                                GoRouter.of(
                                  context,
                                ).push(AppRouter.signupViewRoute);
                              },
                            ),
                          ],
                        ),
                      ],
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
