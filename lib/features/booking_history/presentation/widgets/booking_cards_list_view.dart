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
              return const AppointmentCard();
            case 1:
              return const AppointmentCard();
            case 2:
              return const AppointmentCard();
            default:
              return const AppointmentCard();
          }
        },
      ),
    );
  }
}
