import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'tab_item.dart';

class TapBar extends StatefulWidget {
  final List<String> tabItems;
  final int initialIndex;

  const TapBar({super.key, required this.tabItems, this.initialIndex = 0});

  @override
  State<TapBar> createState() => _TapBarState();
}

class _TapBarState extends State<TapBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _handleTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.gray400, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < widget.tabItems.length; i++)
                  TabItem(
                    text: widget.tabItems[i],
                    isSelected: _selectedIndex == i,
                    onTap: () => _handleTabChange(i),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
