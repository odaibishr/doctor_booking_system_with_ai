import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/bottomsheet_deteals.dart';
import 'package:flutter/material.dart';

class PaymentBottomSheet extends StatelessWidget {
  final String doctorName;
  final String userName;
  final String date;
  final String time;

  const PaymentBottomSheet({
    super.key,
    required this.doctorName,
    required this.userName,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: BottomSheetDeteals(
        doctorName: doctorName,
        userName: userName,
        date: date,
        time: time,
      ),
    );
  }
}
