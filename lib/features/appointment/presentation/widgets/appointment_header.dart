import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AppointmentHeader extends StatelessWidget {
  const AppointmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomAppBar(
        title: 'حجز موعد',
        isBackButtonVisible: true,
        isUserImageVisible: false,
        isHeartIconVisible: false,
      ),
    );
  }
}
