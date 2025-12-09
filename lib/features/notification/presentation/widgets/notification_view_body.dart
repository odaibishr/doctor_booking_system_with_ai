import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/notification/presentation/widgets/notificationCard.dart';

import 'package:flutter/material.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          CustomAppBar(
            title: 'الإشعارات',
            isBackButtonVisible: true,
            isUserImageVisible: false,
          ),
          SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: 6,

              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MedicalNotificationCard(
                    title: 'تم تأكيد الحجز',
                    amount: ' 4,000 YAR',
                    description:
                        'تم تأكيد حجزك لدى د. صادق محمد  بشر  - تخصص مخ واعصاب. الموعد: الثلاثاء 10 ديسمبر - الساعة 4 مساءً.',
                    number: 'رقم الحجز: 102287',
                    date: '19:43 2025/12/07',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
