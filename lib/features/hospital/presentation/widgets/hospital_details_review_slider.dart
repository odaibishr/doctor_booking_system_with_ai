import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/patient_review.dart';
import 'package:flutter/material.dart';

class HospitalDetailsReviewSlider extends StatefulWidget {
  const HospitalDetailsReviewSlider({super.key, required this.reviews});
  final List<Map<String, dynamic>> reviews;

  @override
  State<HospitalDetailsReviewSlider> createState() =>
      _HospitalDetailsReviewSliderState();
}

class _HospitalDetailsReviewSliderState
    extends State<HospitalDetailsReviewSlider> {
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
        final review = widget.reviews[index];
        return PatientReview(
          name: review['name'],
          rating: review['rating'],
          review: review['review'],
        );
      },
      itemCount: 3,
    );
  }
}
