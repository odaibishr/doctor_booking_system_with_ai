import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_details_view_body.dart';
import 'package:flutter/material.dart';

class HospitalDetailsView extends StatelessWidget {
  const HospitalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: HospitalDetailsViewBody()));
  }
}
