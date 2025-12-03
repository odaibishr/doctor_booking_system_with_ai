import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/nav_bar_model_item.dart';

class RowModelNavBar extends StatelessWidget {
  final List<NavBarModelItem> items;

  const RowModelNavBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items
            .map((item) => Expanded(child: item))
            .toList(growable: false),
      ),
    );
  }
}
