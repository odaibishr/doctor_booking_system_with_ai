import 'package:doctor_booking_system_with_ai/features/forget_password/create_new_password/presentation/widget/create_new_password_body.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordView extends StatelessWidget {
  final String email;
  final String otp;
  const CreateNewPasswordView({super.key, required this.email, required this.otp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: CreateNewPasswordBody(email: email, otp: otp)));
  }
}
