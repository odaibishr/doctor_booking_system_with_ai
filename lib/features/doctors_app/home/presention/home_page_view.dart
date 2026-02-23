import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/home_page_view_body.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: SafeArea(child: HomePageViewBody()),);
  }
}