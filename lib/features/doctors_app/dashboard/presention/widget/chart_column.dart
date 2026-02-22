
import 'package:flutter/material.dart';

class ChartColumn extends StatelessWidget {
   final double coulmnHeight;
  const ChartColumn({
    super.key, required this.coulmnHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: coulmnHeight,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}