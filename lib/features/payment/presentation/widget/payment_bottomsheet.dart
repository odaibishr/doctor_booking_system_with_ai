import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/bottomsheet_deteals.dart';
import 'package:flutter/material.dart';

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 1300),
      curve: Curves.easeInOutBack,
      height: MediaQuery.of(context).size.height * 0.55,
      width: double.infinity,
      padding: EdgeInsets.only(top: 45, left: 20, right: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: BottomSheetDeteals(),
    );
  }
}
