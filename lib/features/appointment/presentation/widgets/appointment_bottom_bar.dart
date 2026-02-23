import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:flutter/material.dart';

class AppointmentBottomBar extends StatelessWidget {
  final int currentStep;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AppointmentBottomBar({
    super.key,
    required this.currentStep,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final String primaryLabel = currentStep == 2 ? 'تأكيد' : 'التالي';

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: MainButton(text: primaryLabel, onTap: onNext),
            ),
            if (currentStep > 0) ...[
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: onBack,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: context.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'رجوع',
                      style: FontStyles.subTitle2.copyWith(
                        color: context.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
