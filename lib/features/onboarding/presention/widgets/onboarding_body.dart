import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/animated_indecator.dart';
import 'package:flutter/material.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  int currentIndex = 0;

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<String> images = [
    'assets/images/onbording1.jpg',
    'assets/images/onbording2.jpg',
    'assets/images/onbording3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            final bool isActive = index == currentIndex;

            return AnimatedScale(
              scale: isActive ? 1.0 : 0.88,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                height: isActive ? 240 : 190,
                width: isActive ? 230 : 165,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                margin: EdgeInsets.zero, // إزالة أي مسافات
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      if (!isActive)
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.15),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 260,
            viewportFraction: 0.45,
            enlargeCenterPage: true,
            enlargeFactor: 0,
            autoPlay: false,
            enableInfiniteScroll: true,
            scrollPhysics: const BouncingScrollPhysics(),
            onPageChanged: (index, reason) {
              setState(() => currentIndex = index);
            },
          ),
        ),
        const SizedBox(height: 20),
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: 3,
          itemBuilder: (context, index, realIndex) {
            final bool isActive = index == currentIndex;

            return AnimatedScale(
              scale: isActive ? 1.0 : 0.88,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                height: isActive ? 80 : 65,
                width: isActive ? 260 : 200,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                margin: EdgeInsets.zero, // Remove any margins
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    index == currentIndex ? 'Active text' : '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isActive ? 18 : 16,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 80,
            viewportFraction: 0.45,
            enlargeCenterPage: true,
            enlargeFactor: 0,
            autoPlay: false,
            enableInfiniteScroll: true,
            scrollPhysics: const BouncingScrollPhysics(),
            onPageChanged: (index, reason) {
              setState(() => currentIndex = index);
            },
          ),
        ),
        const SizedBox(height: 20),
        AnimatedIndecator(currentIndex: currentIndex, dotsCount: 3),
      ],
    );
  }
}
