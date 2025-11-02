import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/nav_bar_model_item.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/row_model_nav_bar.dart';
import 'package:flutter/material.dart';

class ModelNavBar extends StatelessWidget {
  const ModelNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 81,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: ShapeDecoration(
        color: const Color(0xFF364989),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Column(
        children: [
          RowModelNavBar(
            items: [
              NavBarModelItem(
                iconPath: 'assets/icons/wanchain.svg',
                label: 'اودي',
              ),
              NavBarModelItem(
                iconPath: 'assets/icons/heart-filled.svg',
                label: 'المفضلة',
              ),
            ],
          ),
          RowModelNavBar(
            items: [
              NavBarModelItem(
                iconPath: 'assets/icons/map.svg',
                label: 'الموقع',
              ),
              NavBarModelItem(
                iconPath: 'assets/icons/card-receive.svg',
                label: 'الحجوزات',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
