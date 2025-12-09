import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class PaymentMethodItem extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onTap;

  const PaymentMethodItem({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xffdb232d),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:    Color(0xffdb232d),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: FontStyles.subTitle3.copyWith(
                color:  const Color.fromARGB(255, 244, 241, 241),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            SvgPicture.asset(
              iconPath,
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(
                AppColors.white ,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
