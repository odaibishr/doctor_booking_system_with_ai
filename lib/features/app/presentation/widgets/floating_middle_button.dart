import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/model_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class FloatingMiddleButton extends StatefulWidget {
  const FloatingMiddleButton({super.key});

  @override
  State<FloatingMiddleButton> createState() => _FloatingMiddleButtonState();
}

class _FloatingMiddleButtonState extends State<FloatingMiddleButton>
    with SingleTickerProviderStateMixin {
  late OverlayEntry overlayEntry;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void showModelNavBar() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _controller.reverse().then((value) => overlayEntry.remove());
              },
              child: Container(color: Colors.black.withValues(alpha: 0.25)),
            ),
          ),
          Positioned(
            left: position.dx - 140,
            top: position.dy - 90,
            child: Material(
              color: Colors.transparent,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ModelNavBar(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(overlayEntry);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.only(bottom: 5, right: 0),
      child: FloatingActionButton(
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 7,
            style: BorderStyle.solid,
            strokeAlign: 1,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 8,
        onPressed: showModelNavBar,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF364989),
          ),
          child: SvgPicture.asset(
            'assets/icons/wanchain.svg',
            width: 30,
            height: 30,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
