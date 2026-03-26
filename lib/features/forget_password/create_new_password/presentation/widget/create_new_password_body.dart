import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/password_input_feild.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/title.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/logo.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordBody extends StatefulWidget {
  final String email;
  final String otp;
  const CreateNewPasswordBody({super.key, required this.email, required this.otp});

  @override
  State<CreateNewPasswordBody> createState() => _CreateNewPasswordBodyState();
}

class _CreateNewPasswordBodyState extends State<CreateNewPasswordBody> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          context.showSuccessToast(state.message);
          context.go(AppRouter.signInViewRoute);
        } else if (state is ResetPasswordFailure) {
          context.showErrorToast(state.message);
        }
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            AppBar2(),
            SliverToBoxAdapter(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                      Logo(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      MainTitle(title: 'إنشاء كلمة مرور جديدة'),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      SubTitle(
                        text:
                            'يجب أن تكون كلمة المرور الجديدة مختلفة كلمة المرور المستخدمة مسبقًا.',
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      PasswordField(
                        controller: passwordController,
                        hintText: 'كلمة المرور الجديدة',
                        validator: passwordValidator,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      PasswordField(
                        controller: confirmPasswordController,
                        hintText: 'تأكيد كلمة المرور',
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'كلمة المرور غير متطابقة';
                          }
                          return passwordValidator(value);
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      state is ResetPasswordLoading
                          ? const Center(child: CircularProgressIndicator())
                          : MainButton(
                              text: 'إعادة تعيين كلمة المرور',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().resetPassword(
                                        email: widget.email,
                                        otp: widget.otp,
                                        password: passwordController.text,
                                        passwordConfirmation: confirmPasswordController.text,
                                      );

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
      },
    );
  }

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال كلمة المرور ';
    } else if (value.length < 8) {
      return 'كلمة المرور يجب ان تكون 8 خانات على الاقل';
    }
    return null;
  }
}
