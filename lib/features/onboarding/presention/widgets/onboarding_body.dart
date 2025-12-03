import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/animated_indecator.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/features/onboarding/presention/widgets/image_carousel.dart';
import 'package:doctor_booking_system_with_ai/features/onboarding/presention/widgets/text_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  final List<Map<String, String>> texts = [
    {
      'title': 'احجز موعدًا مع طبيب عبر الإنترنت',
      'description':
          'سجل واحجز استشارة طبية اونلاين مع أفضل الأطباء المتخصصين في أي وقت ومن أي مكان',
    },
    {
      'title': 'طبيبك الذكي',
      'description':
          'يحلل الذكاء الاصطناعي فحوصاتك، ويختار الطبيب المختص ويحجز موعدك آلياً - راحة وسرعة ودقة!',
    },
    {
      'title': 'تذكيرك بموعدك',
      'description':
          'يتابع تطبيقنا مواعيدك ويذكرك بها مسبقاً عبر التنبيهات، مع تفاصيل العيادة ومتى دخولك عند الطبيب.',
    },
  ];

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image Carousel
        ImageCarousel(
          images: images,
          currentIndex: currentIndex,
          carouselController: _carouselController,
          onPageChanged: _onPageChanged,
        ),
        const SizedBox(height: 50),

        // Text Content
        TextContent(
          title: texts[currentIndex]['title']!,
          description: texts[currentIndex]['description']!,
          isActive: true,
        ),

        const SizedBox(height: 28),

        // Next button if it reach the last page it will navigate to home screen
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: MainButton(
            text: 'التالي',
            onTap: () {
              if (currentIndex < texts.length - 1) {
                _carouselController.nextPage();
              } else {
                GoRouter.of(context).pushReplacement(AppRouter.signInViewRoute);
              }
            },
          ),
        ),

        const SizedBox(height: 34),

        AnimatedIndecator(currentIndex: currentIndex, dotsCount: 3),
      ],
    );
  }
}
