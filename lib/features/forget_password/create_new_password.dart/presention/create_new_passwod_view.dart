import 'package:doctor_booking_system_with_ai/features/forget_password/create_new_password.dart/presention/widget/create_new_password_body.dart';
import 'package:flutter/material.dart';

class CreateNewPasswodView extends StatelessWidget {
  const CreateNewPasswodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: CreateNewPasswordBody()),);
  }
}