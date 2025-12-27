import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';

class BottomSheetDeteals extends StatelessWidget {
  const BottomSheetDeteals({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('حجزك ناجح', style: FontStyles.headLine3.copyWith()),
          SizedBox(height: 10),
          Text(
            'لقد تم حجز موعد مع',
            style: FontStyles.subTitle3.copyWith(color: context.gray500Color),
          ),
          SizedBox(height: 12),
          Text('د. صادق محمد بشر', style: FontStyles.subTitle1),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/userf.svg',
                colorFilter: ColorFilter.mode(
                  context.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                'عدي جلال محمد بشر',
                style: FontStyles.subTitle3.copyWith(
                  color: context.gray600Color,
                ),
              ),
            ],
          ),
          SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/calendarf.svg',
                    colorFilter: ColorFilter.mode(
                      context.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text('30 يوليو 2025', style: FontStyles.subTitle3),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/timerf.svg',
                    colorFilter: ColorFilter.mode(
                      context.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(' 8:00ص - 1:00م', style: FontStyles.subTitle3),
                ],
              ),
            ],
          ),
          SizedBox(height: 34),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MainButton(
              text: 'إظهار الحجز',
              onTap: () {
                GoRouter.of(
                  context,
                ).pushReplacement(AppRouter.appNavigationRoute, extra: 2);
              },
            ),
          ),
          SizedBox(height: 5),
          TextButton(
            child: Text('العودة للرئيسية', style: FontStyles.subTitle1),
            onPressed: () {
              GoRouter.of(context).go(AppRouter.appNavigationRoute);
            },
          ),
        ],
      ),
    );
  }
}
