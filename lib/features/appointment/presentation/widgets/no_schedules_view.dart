import 'package:flutter/material.dart';

class NoSchedulesView extends StatelessWidget {
  const NoSchedulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'لا تتوفر مواعيد حالياً لهذا الطبيب',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'JF-Flat',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
