// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/details_view_actions.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details_view_body.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: DetailsViewBody(doctor: doctor)),
      bottomNavigationBar: DetailsViewActions(),
    );
  }
}
