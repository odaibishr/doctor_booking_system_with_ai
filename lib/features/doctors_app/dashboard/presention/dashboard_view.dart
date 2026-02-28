import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/dashboard_view_body.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/dashboard/doctor_dashboard_cubit.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<DoctorDashboardCubit>()..fetchDashboard(),
      child: const SafeArea(child: DashboardViewBody()),
    );
  }
}
