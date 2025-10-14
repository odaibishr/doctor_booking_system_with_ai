import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/booking_history_view_body.dart';
import 'package:flutter/material.dart';

class BookingHistoryView extends StatelessWidget {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: const BookingHistoryViewBody()));
  }
}
