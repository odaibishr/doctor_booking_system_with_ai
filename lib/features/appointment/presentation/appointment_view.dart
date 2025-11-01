import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/appointment_view_body.dart';
import 'package:flutter/material.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppointmentViewBody(),
      ),
    );
  }
}