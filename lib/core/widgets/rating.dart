import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class Rating extends StatelessWidget {
  const Rating({super.key, required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/star_filled.svg',
          width: 17,
          height: 17,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(width: 2),
        Text(rating.toString(), style: FontStyles.body2),
      ],
    );
  }
}
