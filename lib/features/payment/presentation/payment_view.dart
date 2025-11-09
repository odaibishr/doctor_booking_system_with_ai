import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_view_body.dart';
import 'package:go_router/go_router.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const PaymentViewBody(),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MainButton(text: 'الدفع الان', onTap: () {
          GoRouter.of(context).push(AppRouter.addcardViewRoute);
        }),
      ),
    );
  }
}
