import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/doctor_featured_banner.dart';
import 'package:flutter/material.dart';

class DoctorBannerSlider extends StatelessWidget {
  const DoctorBannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 170,

        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 30),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (context, index, realIndex) {
        return const DoctorFeaturedBanner();
      },
      itemCount: 3,
    );
  }
}
