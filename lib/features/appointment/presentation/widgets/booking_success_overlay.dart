import 'dart:ui';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_bottomsheet.dart';
import 'package:flutter/material.dart';

class BookingSuccessOverlay extends StatelessWidget {
  final String doctorName;
  final String userName;
  final String date;
  final String time;

  const BookingSuccessOverlay({
    super.key,
    required this.doctorName,
    required this.userName,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {},
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.black.withValues(alpha: 0.3)),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: PaymentBottomSheet(
            doctorName: doctorName,
            userName: userName,
            date: date,
            time: time,
          ),
        ),
      ],
    );
  }
}
