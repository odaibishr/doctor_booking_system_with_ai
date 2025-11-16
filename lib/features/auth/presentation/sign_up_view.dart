import 'package:doctor_booking_system_with_ai/features/Auth/signup/presention/widget/sign_up_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SignUpBody()),);
  }
}