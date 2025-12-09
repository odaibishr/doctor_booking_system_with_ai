import 'package:doctor_booking_system_with_ai/features/forget_password/email_input/presentation/widget/email_input_body.dart';
import 'package:flutter/material.dart';

class EmailInputView extends StatelessWidget {
  const EmailInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: EmailInputBody()));
  }
}
