import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/JaibDialogContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class JaibShowDialog extends StatelessWidget {
  const JaibShowDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: JaibDialogContent(),
    );
  }
}

