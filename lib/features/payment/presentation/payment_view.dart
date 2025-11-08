import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_view_body.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      PaymentViewBody()
      ),
    );
  }
}