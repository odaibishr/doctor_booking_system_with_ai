import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PageTransitionType {
  fade,

  slideRight,

  slideLeft,

  slideUp,

  slideDown,

  scale,

  scaleWithFade,

  sharedAxis,

  fadeThrough,
}

class TransitionDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration verySlow = Duration(milliseconds: 500);
}

class TransitionCurves {
  static const Curve standard = Curves.easeInOut;
  static const Curve decelerate = Curves.decelerate;
  static const Curve accelerate = Curves.easeIn;
  static const Curve smooth = Curves.fastOutSlowIn;
  static const Curve bouncy = Curves.elasticOut;
  static const Curve gentle = Curves.easeOutCubic;
}

class CustomPageTransition<T> extends CustomTransitionPage<T> {
  CustomPageTransition({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
    PageTransitionType transitionType = PageTransitionType.fade,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) : super(
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return _buildTransition(
             transitionType: transitionType,
             animation: animation,
             secondaryAnimation: secondaryAnimation,
             child: child,
             curve: curve,
           );
         },
       );
}

Widget _buildTransition({
  required PageTransitionType transitionType,
  required Animation<double> animation,
  required Animation<double> secondaryAnimation,
  required Widget child,
  required Curve curve,
}) {
  final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

  switch (transitionType) {
    case PageTransitionType.fade:
      return FadeTransition(opacity: curvedAnimation, child: child);

    case PageTransitionType.slideRight:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );

    case PageTransitionType.slideLeft:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );

    case PageTransitionType.slideUp:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );

    case PageTransitionType.slideDown:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );

    case PageTransitionType.scale:
      return ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
        child: child,
      );

    case PageTransitionType.scaleWithFade:
      return FadeTransition(
        opacity: curvedAnimation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(curvedAnimation),
          child: child,
        ),
      );

    case PageTransitionType.sharedAxis:
      return _SharedAxisTransition(animation: curvedAnimation, child: child);

    case PageTransitionType.fadeThrough:
      return _FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
  }
}

class _SharedAxisTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _SharedAxisTransition({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.05),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}

class _FadeThroughTransition extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  const _FadeThroughTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
          ),
        ),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      ),
    );
  }
}

class PageTransitionBuilder {
  static CustomPageTransition<T> fade<T>({
    required Widget child,
    String? name,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomPageTransition<T>(
      child: child,
      name: name,
      transitionType: PageTransitionType.fade,
      duration: duration,
      curve: TransitionCurves.smooth,
    );
  }

  static CustomPageTransition<T> slideRight<T>({
    required Widget child,
    String? name,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomPageTransition<T>(
      child: child,
      name: name,
      transitionType: PageTransitionType.slideRight,
      duration: duration,
      curve: TransitionCurves.gentle,
    );
  }

  static CustomPageTransition<T> slideUp<T>({
    required Widget child,
    String? name,
    Duration duration = const Duration(milliseconds: 350),
  }) {
    return CustomPageTransition<T>(
      child: child,
      name: name,
      transitionType: PageTransitionType.slideUp,
      duration: duration,
      curve: TransitionCurves.smooth,
    );
  }

  static CustomPageTransition<T> scaleWithFade<T>({
    required Widget child,
    String? name,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomPageTransition<T>(
      child: child,
      name: name,
      transitionType: PageTransitionType.scaleWithFade,
      duration: duration,
      curve: TransitionCurves.smooth,
    );
  }

  static CustomPageTransition<T> sharedAxis<T>({
    required Widget child,
    String? name,
    Duration duration = const Duration(milliseconds: 350),
  }) {
    return CustomPageTransition<T>(
      child: child,
      name: name,
      transitionType: PageTransitionType.sharedAxis,
      duration: duration,
      curve: TransitionCurves.smooth,
    );
  }

  static CustomPageTransition<T> fadeThrough<T>({
    required Widget child,
    String? name,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return CustomPageTransition<T>(
      child: child,
      name: name,
      transitionType: PageTransitionType.fadeThrough,
      duration: duration,
      curve: TransitionCurves.smooth,
    );
  }
}
