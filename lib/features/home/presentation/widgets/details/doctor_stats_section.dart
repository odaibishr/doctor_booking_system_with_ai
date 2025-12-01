import 'package:doctor_booking_system_with_ai/core/widgets/states_item.dart';
import 'package:flutter/material.dart';

class DoctorStatsSection extends StatelessWidget {
  const DoctorStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatesItem(
          icon: 'assets/icons/people.svg',
          text: 'مريض',
          number: '3000+',
        ),

        StatesItem(
          icon: 'assets/icons/calendar1.svg',
          text: 'خبرة',
          number: '10+',
        ),

        StatesItem(
          icon: 'assets/icons/star.svg',
          text: 'التقييم',
          number: '4.9+',
        ),

        StatesItem(icon: 'assets/icons/map.svg', text: 'الموقع', number: '3KM'),
      ],
    );
  }
}
