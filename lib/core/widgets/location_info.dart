import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key, required this.location, required this.color});
  final String location;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/location.svg',
          width: 10,
          height: 10,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        const SizedBox(width: 2),
        Text(location, style: FontStyles.body3.copyWith(color: color)),
      ],
    );
  }
}
