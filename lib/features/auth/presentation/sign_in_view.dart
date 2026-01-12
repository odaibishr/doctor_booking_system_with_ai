import 'package:flutter/material.dart';

import 'package:doctor_booking_system_with_ai/features/auth/presentation/widgets/sign_in_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SignInBody()));
  }
}
