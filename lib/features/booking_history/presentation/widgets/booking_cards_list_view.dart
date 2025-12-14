import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';

class BookingCardsListView extends StatelessWidget {
  const BookingCardsListView({
    super.key,
    required this.bookings,
    required this.status,
  });

  final List<Booking> bookings;
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return const Center(child: Text('لا توجد حجوزات في هذا القسم حالياً'));
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: bookings.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return AppointmentCard(
          booking: bookings[index],
          status: status,
        );
      },
    );
  }
}
