import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HospitalDetailsViewBody extends StatelessWidget {
  const HospitalDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          CustomAppBar(
            title: 'معلومات المستشفى',
            isBackButtonVisible: true,
            isUserImageVisible: false,
            isHeartIconVisible: false,
          ),
        ],
      ),
    );
  }
}
