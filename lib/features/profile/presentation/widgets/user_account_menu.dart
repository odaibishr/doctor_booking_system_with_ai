import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/confirm_action_dialog.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/widgets/user_account_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAccountMenu extends StatefulWidget {
  const UserAccountMenu({super.key});

  @override
  State<UserAccountMenu> createState() => _UserAccountMenuState();
}

class _UserAccountMenuState extends State<UserAccountMenu> {
  bool _isSupportExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserAccountMenuItem(
              title: 'الحساب الشخصي',
              icon: 'assets/icons/user.svg',
              onTap: () {},
            ),
            const SizedBox(height: 14),

            UserAccountMenuItem(
              title: 'الإعدادات',
              icon: 'assets/icons/setting-2.svg',
              onTap: () {},
            ),
            const SizedBox(height: 14),

            UserAccountMenuItem(
              title: 'الدعم والمساعدة',
              icon: 'assets/icons/warning-2.svg',
              onTap: () {
                setState(() {
                  _isSupportExpanded = !_isSupportExpanded;
                });
              },
            ),
            const SizedBox(height: 14),

            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: _isSupportExpanded ? 10 : 0,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRect(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: _isSupportExpanded
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      UserAccountMenuItem(
                        title: 'اللغة',
                        icon: 'assets/icons/setting-2.svg',
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      UserAccountMenuItem(
                        title: 'الإشعارات',
                        icon: 'assets/icons/setting-2.svg',
                        onTap: () {},
                      ),
                    ],
                  ),
                  secondChild: const SizedBox.shrink(),
                ),
              ),
            ),
            const SizedBox(height: 14),

            UserAccountMenuItem(
              title: 'تسجيل الخروج',
              icon: 'assets/icons/login.svg',
              onTap: () async {
                final authCubit = context.read<AuthCubit>();
                final confirmed = await ConfirmActionDialog.show(
                  context,
                  title: 'تسجيل الخروج',
                  message: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                  confirmText: 'نعم',
                  cancelText: 'لا',
                  icon: Icons.logout,
                  confirmColor: AppColors.error,
                );

                if (!context.mounted || !confirmed) return;

                await authCubit.logout();
                if (!context.mounted) return;
                context.showSuccessToast('تم تسجيل الخروج بنجاح');
              },
            ),
          ],
        ),
      ),
    );
  }
}
