// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:doctor_booking_system_with_ai/core/widgets/animated_indecator.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/doctor_featured_banner.dart';

class DoctorBannerSlider extends StatefulWidget {
  const DoctorBannerSlider({super.key, required this.featuredDoctor});
  final List<Doctor> featuredDoctor;

  @override
  State<DoctorBannerSlider> createState() => _DoctorBannerSliderState();
}

class _DoctorBannerSliderState extends State<DoctorBannerSlider> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 180,

            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 30),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return DoctorFeaturedBanner(doctor: widget.featuredDoctor[index]);
          },
          itemCount: widget.featuredDoctor.length,
        ),
        const SizedBox(height: 10),
        AnimatedIndecator(
          currentIndex: currentIndex,
          dotsCount: widget.featuredDoctor.length,
        ),
      ],
    );
  }
}
