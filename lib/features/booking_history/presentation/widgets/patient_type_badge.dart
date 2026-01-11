import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class PatientTypeBadge extends StatelessWidget {
  const PatientTypeBadge({super.key, required this.isReturning});
  final bool isReturning;

  @override
  Widget build(BuildContext context) {
    final color = isReturning ? context.primaryColor : context.gray600Color;
    final text = isReturning ? 'عائد' : 'جديد';
    final icon = isReturning ? Icons.replay : Icons.fiber_new;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
