import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presentation/widget/create_profile_body.dart';
import 'package:flutter/material.dart';

class CreateProfileView extends StatelessWidget {
  const CreateProfileView({super.key, this.profile});
  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: CreateProfileBody(profile: profile)),
    );
  }
}
