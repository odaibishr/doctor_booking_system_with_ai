import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/data_booking.dart';
import 'package:flutter/material.dart';

class AppointmentViewBody extends StatelessWidget {
  const AppointmentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          CustomAppBar(
            title: 'حجز موعد',
            isBackButtonVisible: true,
            isUserImageVisible: false,
            isHeartIconVisible: false,
          ),
          const SizedBox(height: 20),
          const DataBooking(),
        ],
      ),
    );
  }
}
