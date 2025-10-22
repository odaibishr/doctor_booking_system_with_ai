import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/animated_indecator.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboardingpages extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final int index;
  final PageController pagecontroller;

  const Onboardingpages({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.index,
    required this.pagecontroller,
  });

  @override
  State<Onboardingpages> createState() => _OnboardingpagesState();
}

class _OnboardingpagesState extends State<Onboardingpages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        //image
        Image.asset(widget.image),
        SizedBox(height: 30),
        //title
        Text(widget.title, style: FontStyles.headLine4),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          //description
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            style: FontStyles.subTitle3.copyWith(color: AppColors.gray400),
            maxLines: 3,
          ),
        ),
        SizedBox(height: 22),
        //Button !
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: MainButton(
            text: 'التالي',
            onTap: () {
              //TODO:here the ontap fucntion
              if (widget.index < 2) {
                widget.pagecontroller.nextPage(
                  duration: Duration(milliseconds: 350),
                  curve: Curves.easeIn,
                );
              } else {
                //GO To Navigation Screen(Page)!
                GoRouter.of(context).go(AppRouter.appNavigationRoute);
              }
            },
          ),
        ),
        SizedBox(height: 15),
        //To Changed the direction of indecator L
        Directionality(child:
         AnimatedIndecator(currentIndex: widget.index, dotsCount: 3),
          textDirection: TextDirection.ltr,
        ),
        SizedBox(height: 45),
        GestureDetector(
          child: Text(
            '<< تخطي',
            style: FontStyles.subTitle3.copyWith(color: AppColors.primary),
          ),
          onTap: () {
            GoRouter.of(context).go(AppRouter.appNavigationRoute);
          },
        ),
      ],
    );
  }
}
