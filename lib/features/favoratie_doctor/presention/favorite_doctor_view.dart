import 'package:doctor_booking_system_with_ai/features/favoratie_doctor/presention/favorite_doctor_body.dart';
import 'package:flutter/material.dart';

class FavoratieDoctorView extends StatelessWidget {
  const FavoratieDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: FavoriteDoctorBody()));
  }
}