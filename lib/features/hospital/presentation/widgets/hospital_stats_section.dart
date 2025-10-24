import 'package:doctor_booking_system_with_ai/core/widgets/states_item.dart';
import 'package:flutter/material.dart';

class HospitalStatsSection extends StatelessWidget {
  const HospitalStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatesItem(icon: 'assets/icons/send-2.svg', text: 'مشاركة'),
        StatesItem(icon: 'assets/icons/chrome.svg', text: 'صفحتنا'),
        StatesItem(icon: 'assets/icons/call.svg', text: 'اتصل بنا'),
        StatesItem(icon: 'assets/icons/map.svg', text: 'الاتجاهات'),
      ],
    );
  }
}
