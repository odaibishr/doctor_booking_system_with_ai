import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final CarouselSliderController carouselController;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  const ImageCarousel({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.carouselController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: carouselController,
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
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                  if (!isActive)
                    ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.transparent,
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
        onPageChanged: onPageChanged,
      ),
    );
  }
}
