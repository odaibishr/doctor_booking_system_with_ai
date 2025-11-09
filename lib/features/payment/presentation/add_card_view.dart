
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/add_card_body.dart';
import 'package:flutter/material.dart';

class AddCardView extends StatelessWidget {
  const AddCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,
      body: SafeArea(child: SafeArea(child: AddCardBody())),
      
    );
  }
}
