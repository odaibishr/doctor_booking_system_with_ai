import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/widgets/edit_profile_body.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  final Profile profile;
  const EditProfileView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: EditProfileBody(profile: profile));
  }
}
