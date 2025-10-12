import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.icon,
  });

  final String icon;
  final int index;
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: SvgPicture.asset(
                  isSelected ? icon : icon,
                  key: ValueKey<bool>(isSelected),
                  colorFilter: isSelected
                      ? ColorFilter.mode(
                          const Color(0xFF364989), BlendMode.srcIn)
                      : null,
                  width: isSelected ? 26 : 24,
                  height: isSelected ? 26 : 24,
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
