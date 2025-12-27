import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/tab_item.dart';
import 'package:flutter/material.dart';

class TapBar extends StatelessWidget {
  final List<String> tabItems;
  final int selectedTab;
  final Function(int) onTabChanged;

  const TapBar({
    super.key,
    required this.tabItems,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(color: context.gray200Color, width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < tabItems.length; i++)
            TabItem(
              text: tabItems[i],
              isSelected: selectedTab == i,
              onTap: () => onTabChanged(i),
            ),
        ],
      ),
    );
  }
}
