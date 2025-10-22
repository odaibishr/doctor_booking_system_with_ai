import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/widget/sign_in_body.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SignInBody()),);
  }
}