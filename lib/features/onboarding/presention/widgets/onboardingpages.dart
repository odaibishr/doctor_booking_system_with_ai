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
  final VoidCallback onNext;

  const Onboardingpages({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.index,
    required this.onNext,
  });

  @override
  State<Onboardingpages> createState() => _OnboardingpagesState();
}

class _OnboardingpagesState extends State<Onboardingpages>
    with TickerProviderStateMixin {
  late final AnimationController _imageController;
  late final AnimationController _textController;
  late final Animation<Offset> _imageOffset;
  late final Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _imageOffset = Tween<Offset>(
      begin: const Offset(1, 0), // الصورة تبدأ من اليمين
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOut));

    _textOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    // نبدأ الأنيميشن عند عرض الصفحة
    _runAnimations();
  }

  void _runAnimations() async {
    await _imageController.forward();
    await _textController.forward();
  }

  @override
  void didUpdateWidget(Onboardingpages oldWidget) {
    super.didUpdateWidget(oldWidget);
    // إعادة تشغيل الأنيميشن عند تغيير الصفحة
    _imageController.reset();
    _textController.reset();
    _runAnimations();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        // الصورة تتحرك لوحدها
        SlideTransition(
          position: _imageOffset,
          child: Image.asset(widget.image, height: 260),
        ),
        const SizedBox(height: 30),
        // النصوص تظهر تدريجيًا
        FadeTransition(
          opacity: _textOpacity,
          child: Column(
            children: [
              Text(widget.title, style: FontStyles.headLine4),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: FontStyles.subTitle3.copyWith(
                    color: AppColors.gray400,
                  ),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: MainButton(
            text: widget.index < 2 ? 'التالي' : 'ابدأ الآن',
            onTap: () {
              if (widget.index < 2) {
                widget.onNext();
              } else {
                GoRouter.of(context).go(AppRouter.appNavigationRoute);
              }
            },
          ),
        ),
        AnimatedIndecator(currentIndex: widget.index, dotsCount: 3),
        const SizedBox(height: 35),
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
