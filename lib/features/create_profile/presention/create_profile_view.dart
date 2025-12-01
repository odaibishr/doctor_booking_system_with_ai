import 'package:doctor_booking_system_with_ai/features/create_profile/presention/widget/create_profile_body.dart';
import 'package:flutter/material.dart';

class CreateProfileView extends StatelessWidget {
  const CreateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: CreateProfileBody()));
  }
}
