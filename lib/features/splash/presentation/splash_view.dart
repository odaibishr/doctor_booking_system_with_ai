import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationOpacity;
  late Animation<double> _animationScale;
  late Animation<Offset> _animationSlide;
  late Animation<Color?> _animationColor;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _animationOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
      ),
    );

    _animationScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _animationSlide =
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.1, 0.5, curve: Curves.easeOut),
          ),
        );

    _animationColor =
        ColorTween(
          begin: AppColors.primaryColor,
          end: AppColors.primaryColor,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
          ),
        );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
      ),
    );

    _startAnimation();
  }

  void _startAnimation() async {
    await _animationController.forward();

    // Navigate to HomeView
    if (mounted) {
        GoRouter.of(context).go(AppRouter.homeViewRoute);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animationColor.value ?? AppColors.primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _animationSlide,
                  child: Opacity(
                    opacity: _animationOpacity.value,
                    child: Transform.scale(
                      scale: _animationScale.value * _pulseAnimation.value,
                      child: Image.asset(
                        'assets/icons/logo-transparent.png',
                        width: 170,
                        height: 170,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
