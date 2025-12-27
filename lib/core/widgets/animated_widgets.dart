import 'package:flutter/material.dart';

class AnimatedListItem extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final AnimationType animationType;

  const AnimatedListItem({
    super.key,
    required this.child,
    required this.index,
    this.delay = const Duration(milliseconds: 50),
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
    this.animationType = AnimationType.fadeSlideUp,
  });

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _slideAnimation = Tween<Offset>(
      begin: _getBeginOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    Future.delayed(widget.delay * widget.index, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  Offset _getBeginOffset() {
    switch (widget.animationType) {
      case AnimationType.fadeSlideUp:
        return const Offset(0.0, 0.3);
      case AnimationType.fadeSlideDown:
        return const Offset(0.0, -0.3);
      case AnimationType.fadeSlideRight:
        return const Offset(0.3, 0.0);
      case AnimationType.fadeSlideLeft:
        return const Offset(-0.3, 0.0);
      case AnimationType.fadeScale:
        return Offset.zero;
      case AnimationType.fade:
        return Offset.zero;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.animationType) {
      case AnimationType.fadeSlideUp:
      case AnimationType.fadeSlideDown:
      case AnimationType.fadeSlideRight:
      case AnimationType.fadeSlideLeft:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: widget.child,
          ),
        );
      case AnimationType.fadeScale:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
        );
      case AnimationType.fade:
        return FadeTransition(opacity: _fadeAnimation, child: widget.child);
    }
  }
}

enum AnimationType {
  fadeSlideUp,
  fadeSlideDown,
  fadeSlideRight,
  fadeSlideLeft,
  fadeScale,
  fade,
}

class AnimatedEntrance extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final AnimationType animationType;

  const AnimatedEntrance({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
    this.animationType = AnimationType.fadeSlideUp,
  });

  @override
  State<AnimatedEntrance> createState() => _AnimatedEntranceState();
}

class _AnimatedEntranceState extends State<AnimatedEntrance>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _slideAnimation = Tween<Offset>(
      begin: _getBeginOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  Offset _getBeginOffset() {
    switch (widget.animationType) {
      case AnimationType.fadeSlideUp:
        return const Offset(0.0, 0.1);
      case AnimationType.fadeSlideDown:
        return const Offset(0.0, -0.1);
      case AnimationType.fadeSlideRight:
        return const Offset(0.1, 0.0);
      case AnimationType.fadeSlideLeft:
        return const Offset(-0.1, 0.0);
      case AnimationType.fadeScale:
        return Offset.zero;
      case AnimationType.fade:
        return Offset.zero;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.animationType) {
      case AnimationType.fadeSlideUp:
      case AnimationType.fadeSlideDown:
      case AnimationType.fadeSlideRight:
      case AnimationType.fadeSlideLeft:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: widget.child,
          ),
        );
      case AnimationType.fadeScale:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
        );
      case AnimationType.fade:
        return FadeTransition(opacity: _fadeAnimation, child: widget.child);
    }
  }
}

class AnimatedRipple extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AnimatedRipple({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutQuart,
  });

  @override
  State<AnimatedRipple> createState() => _AnimatedRippleState();
}

class _AnimatedRippleState extends State<AnimatedRipple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}

class StaggeredAnimationBuilder extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Duration staggerDuration;
  final Duration animationDuration;
  final Curve curve;
  final AnimationType animationType;

  const StaggeredAnimationBuilder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.staggerDuration = const Duration(milliseconds: 50),
    this.animationDuration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
    this.animationType = AnimationType.fadeSlideUp,
  });

  @override
  State<StaggeredAnimationBuilder> createState() =>
      _StaggeredAnimationBuilderState();
}

class _StaggeredAnimationBuilderState extends State<StaggeredAnimationBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.itemCount,
        (index) => AnimatedListItem(
          index: index,
          delay: widget.staggerDuration,
          duration: widget.animationDuration,
          curve: widget.curve,
          animationType: widget.animationType,
          child: widget.itemBuilder(context, index),
        ),
      ),
    );
  }
}

extension AnimatedWidgetExtension on Widget {
  Widget animateEntrance({
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOutCubic,
    AnimationType animationType = AnimationType.fadeSlideUp,
  }) {
    return AnimatedEntrance(
      duration: duration,
      delay: delay,
      curve: curve,
      animationType: animationType,
      child: this,
    );
  }

  Widget animateListItem({
    required int index,
    Duration delay = const Duration(milliseconds: 50),
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutCubic,
    AnimationType animationType = AnimationType.fadeSlideUp,
  }) {
    return AnimatedListItem(
      index: index,
      delay: delay,
      duration: duration,
      curve: curve,
      animationType: animationType,
      child: this,
    );
  }
}
