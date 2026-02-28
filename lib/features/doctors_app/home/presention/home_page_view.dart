import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/home_page_view_body.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/appointments/doctor_appointments_cubit.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<DoctorAppointmentsCubit>()..fetchUpcoming(),
      child: const SafeArea(child: HomePageViewBody()),
    );
  }
}
