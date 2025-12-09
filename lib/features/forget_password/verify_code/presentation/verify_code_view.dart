import 'package:doctor_booking_system_with_ai/features/forget_password/verify_code/presentation/widget/verify_code_body.dart';
import 'package:flutter/material.dart';

class VerifyCodeView extends StatelessWidget {
  const VerifyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: VerifyCodeBody()));
  }
}
