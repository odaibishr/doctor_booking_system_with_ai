import 'package:doctor_booking_system_with_ai/features/onboarding/presention/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: const OnBoardingBody()));
  }
}
