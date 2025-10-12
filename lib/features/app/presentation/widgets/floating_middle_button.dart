import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class FloatingMiddleButton extends StatelessWidget {
  const FloatingMiddleButton({super.key});

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
        onPressed: () {
          // TODO: implement this
        },
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
