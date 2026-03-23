import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, required this.loaderSize});

  final double loaderSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/animated-icon/loading-logo.gif',
            width: loaderSize,
            height: loaderSize,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(height: 8),
          Text(
            'جاري التحميل...',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.primaryColor,
              fontFamily: 'JF-Flat',
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
