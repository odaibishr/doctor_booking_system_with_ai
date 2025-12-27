import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class TabItem extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const TabItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _indicatorWidthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _indicatorWidthAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    if (widget.isSelected) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(TabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              widget.text,
              style: FontStyles.subTitle3.copyWith(
                color: widget.isSelected
                    ? AppColors.primary
                    : AppColors.gray500,
                fontWeight: widget.isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _indicatorWidthAnimation,
            builder: (context, child) {
              return Container(
                height: 3,
                width: 50 * _indicatorWidthAnimation.value,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
