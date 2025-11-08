import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/nav_bar_model_item.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/widgets/row_model_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModelNavBar extends StatelessWidget {
  const ModelNavBar({super.key, this.onClose});
  final VoidCallback? onClose;

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
        spacing: 15,
        children: [
          RowModelNavBar(
            items: [
              NavBarModelItem(
                iconPath: 'assets/icons/wanchain.svg',
                label: 'اودي',
                onTap: () {
                  onClose?.call();
                  GoRouter.of(context).push(AppRouter.aichatViewRoute);
                },
              ),
              NavBarModelItem(
                iconPath: 'assets/icons/heart-filled.svg',
                label: 'المفضلة',
                onTap: () {
                  onClose?.call();
                  GoRouter.of(context).push(AppRouter.favoritedoctorViewRoute);
                },
              ),
            ],
          ),
          RowModelNavBar(
            items: [
              NavBarModelItem(
                iconPath: 'assets/icons/map.svg',
                label: 'الموقع',
                onTap: () {
                  onClose?.call();
                  GoRouter.of(context).push(AppRouter.aichatViewRoute);
                },
              ),
              NavBarModelItem(
                iconPath: 'assets/icons/card-receive.svg',
                label: 'الحجوزات',
                onTap: () {
                  onClose?.call();
                  GoRouter.of(context).push(AppRouter.aichatViewRoute);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
