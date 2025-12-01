import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/patient_review.dart';
import 'package:flutter/material.dart';

class PatientReviewSlider extends StatefulWidget {
  const PatientReviewSlider({super.key});

  @override
  State<PatientReviewSlider> createState() => _PatientReviewSliderState();
}

class _PatientReviewSliderState extends State<PatientReviewSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: _carouselController,
      options: CarouselOptions(
        height: 90,
        viewportFraction: 0.85,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 30),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        return PatientReview(
          name: 'عدي جلال بشر',
          rating: '4.5',
          review:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
        );
      },
      itemCount: 3,
    );
  }
}
