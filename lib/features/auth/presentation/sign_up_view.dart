import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/sign_up_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SignUpBody()));
  }
}
