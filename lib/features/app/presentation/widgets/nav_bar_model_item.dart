import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class NavBarModelItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  const NavBarModelItem({
    super.key,
    required this.iconPath,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          const SizedBox(width: 11),
          Text(
            label,
            style: FontStyles.subTitle1.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
