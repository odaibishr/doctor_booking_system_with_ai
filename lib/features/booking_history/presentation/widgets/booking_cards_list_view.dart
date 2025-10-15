import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';

class BookingCardsListView extends StatelessWidget {
  const BookingCardsListView({super.key, required this.currentTabIndex});
  final int currentTabIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          switch (currentTabIndex) {
            case 0:
              return const AppointmentCard(
                textButton1: 'حجز موعد',
                textButton2: 'إلغاء الحجز',
                status: AppointmentStatus.upcoming,
              );
            case 1:
              return const AppointmentCard(
                textButton1: 'حجز جديد',
                textButton2: 'تقييم الدكتور',
                status: AppointmentStatus.completed,
              );
            case 2:
              return const AppointmentCard(
                textButton1: 'تعديل الحجز',
                textButton2: 'حجز جديد',
                status: AppointmentStatus.cancelled,
              );
            default:
              return const AppointmentCard(
                textButton1: 'حجز موعد',
                textButton2: 'إلغاء الحجز',
                status: AppointmentStatus.upcoming,
              );
          }
        },
      ),
    );
  }
}
