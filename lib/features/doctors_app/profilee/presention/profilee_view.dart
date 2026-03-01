import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/widget/profile_view_body.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileeView extends StatelessWidget {
  const ProfileeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<DoctorProfileCubit>()..fetchProfile(),
      child: const ProfileeViewBody(),
    );
  }
}
