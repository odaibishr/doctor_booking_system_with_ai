import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/subtitle.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/title.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmailInputBody extends StatefulWidget {
  const EmailInputBody({super.key});

  @override
  State<EmailInputBody> createState() => _EmailInputBodyState();
}

class _EmailInputBodyState extends State<EmailInputBody> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          context.showSuccessToast(state.message);
          context.push(AppRouter.verifyCodeViewRoute, extra: emailController.text);
        } else if (state is ForgotPasswordFailure) {
          context.showErrorToast(state.message);
        }
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: CustomAppBar(
                title: '',
                isBackButtonVisible: true,
                isUserImageVisible: false,
              ),
              automaticallyImplyLeading: false,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                      Logo(),
                      MainTitle(title: 'نسيت كلمة المرور'),
                      SizedBox(height: 14),
                      SubTitle(
                        text: 'أدخل بريدك الإلكتروني و سنرسل لك رمز التحقق.',
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      MainInputField(
                        controller: emailController,
                        hintText: 'الحساب الالكتروني',
                        leftIconPath: 'assets/icons/email.svg',
                        rightIconPath: 'assets/icons/email.svg',
                        isShowRightIcon: true,
                        isShowLeftIcon: false,
                        validator: emailValidator,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      state is ForgotPasswordLoading
                          ? const Center(child: CircularProgressIndicator())
                          : MainButton(
                              text: 'إرسال الرمز',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().forgotPassword(emailController.text);
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

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال البريد الالكتروني ';
    } else if (!value.contains('@')) {
      return 'الرجاء ادخال بريد الكتروني صحيح ';
    }
    return null;
  }
}
