import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AnimatedIndecator extends StatelessWidget {
  const AnimatedIndecator({
    super.key,
    required this.currentIndex,
    required this.dotsCount,
  });
  final int currentIndex;
  final int dotsCount;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: currentIndex,
      count: dotsCount,
      effect: ExpandingDotsEffect(
        activeDotColor: context.primaryColor,
        dotColor: context.gray400Color,
        dotHeight: 8,
        dotWidth: 8,
        spacing: 8,
        expansionFactor: 3,
      ),
    );
  }
}
