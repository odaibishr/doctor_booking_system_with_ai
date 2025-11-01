import 'package:doctor_booking_system_with_ai/features/forget_password/verfiy_code/presention/widget/verfiy_code_body.dart';
import 'package:flutter/material.dart';

class VerfiyCodeView extends StatelessWidget {
  const VerfiyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: VerfiyCodeBody()),);
  }
}