import 'dart:ui';

import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_view_body.dart';
import 'package:svg_flutter/svg.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  bool complete_payment = false;
  void showBottomSheetNow() {
    setState(() {
      complete_payment = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: PaymentViewBody(
                complete_payment: complete_payment,
                onpres: showBottomSheetNow,
              ),
            ),
            if (complete_payment == true)
              Positioned.fill(
                top: MediaQuery.of(context).size.height*0.49,
                left: 8.0,
                right: 8.0,
                bottom: 10.0,
               child:  BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: PaymentBottomSheet(),
              )),
              if (complete_payment == true)
            Positioned(
              right: 145,
              bottom: 370,
              child: SvgPicture.asset('assets/images/sucess.svg',),
            ),
          ],
        ),
      ),
    );
  }
}
