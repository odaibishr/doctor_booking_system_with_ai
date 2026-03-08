import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class AppointmentActionButtons extends StatelessWidget {
  const AppointmentActionButtons({
    super.key,
    required this.onConfirm,
    required this.onReject,
    this.confirmText = 'تأكيد',
    this.rejectText = 'رفض',
  });

  final VoidCallback onConfirm;
  final VoidCallback onReject;
  final String confirmText;
  final String rejectText;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onConfirm,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                confirmText,
                style: FontStyles.subTitle3.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: onReject,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.getGray300(context)),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                rejectText,
                style: FontStyles.subTitle3.copyWith(
                  color: context.textSecondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
