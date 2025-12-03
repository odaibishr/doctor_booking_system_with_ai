import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/review_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';

class DetailsViewActions extends StatelessWidget {
  const DetailsViewActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: MainButton(
              text: 'حجز موعد',
              onTap: () {
                GoRouter.of(context).push(AppRouter.appointmentViewRoute);
              },
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                barrierColor: Colors.black54,
                useSafeArea: true,
                builder: (context) {
                  return ReviewDialog(onSubmit: (review) {});
                },
              );
            },
            child: Tooltip(
              message: 'إضافة مراجعة',
              child: Container(
                width: 45,
                height: 45,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.gray300),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/messages.svg',
                    width: 25,
                    height: 25,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
