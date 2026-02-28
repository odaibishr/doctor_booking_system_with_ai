import 'package:doctor_booking_system_with_ai/features/doctors_app/dashboard/presention/widget/dashboard_view_body.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: DashboardViewBody());
  }
}
