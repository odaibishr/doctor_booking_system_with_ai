import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';

class BottomSheetDeteals extends StatelessWidget {
  final String doctorName;
  final String userName;
  final String date;
  final String time;

  const BottomSheetDeteals({
    super.key,
    required this.doctorName,
    required this.userName,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.15),
                  AppColors.primary.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.check_circle_rounded,
              size: 52,
              color: context.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'حجزك ناجح!',
            style: FontStyles.headLine3.copyWith(
              fontWeight: FontWeight.w800,
              color: context.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'لقد تم حجز موعدك بنجاح',
            style: FontStyles.subTitle3.copyWith(color: context.gray500Color),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.primaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              children: [
                _infoRow(
                  context,
                  icon: Icons.person_rounded,
                  label: 'الطبيب',
                  value: 'د. $doctorName',
                ),
                Divider(
                  color: context.primaryColor.withValues(alpha: 0.1),
                  height: 24,
                ),
                _infoRow(
                  context,
                  iconPath: 'assets/icons/userf.svg',
                  label: 'المريض',
                  value: userName,
                ),
                Divider(
                  color: context.primaryColor.withValues(alpha: 0.1),
                  height: 24,
                ),
                _infoRow(
                  context,
                  iconPath: 'assets/icons/calendarf.svg',
                  label: 'التاريخ',
                  value: date,
                ),
                Divider(
                  color: context.primaryColor.withValues(alpha: 0.1),
                  height: 24,
                ),
                _infoRow(
                  context,
                  iconPath: 'assets/icons/timerf.svg',
                  label: 'الوقت',
                  value: time,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          MainButton(
            text: 'إظهار الحجز',
            onTap: () {
              GoRouter.of(
                context,
              ).pushReplacement(AppRouter.appNavigationRoute, extra: 2);
            },
          ),
          const SizedBox(height: 8),
          TextButton(
            child: Text(
              'العودة للرئيسية',
              style: FontStyles.subTitle2.copyWith(
                color: context.gray500Color,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              GoRouter.of(context).go(AppRouter.appNavigationRoute);
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _infoRow(
    BuildContext context, {
    IconData? icon,
    String? iconPath,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: context.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: iconPath != null
                ? SvgPicture.asset(
                    iconPath,
                    width: 18,
                    height: 18,
                    colorFilter: ColorFilter.mode(
                      context.primaryColor,
                      BlendMode.srcIn,
                    ),
                  )
                : Icon(icon, size: 18, color: context.primaryColor),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: FontStyles.subTitle3.copyWith(
                  color: context.gray500Color,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: FontStyles.subTitle2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
