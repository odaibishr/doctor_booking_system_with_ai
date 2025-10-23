import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class MainInputField extends StatelessWidget {
  const MainInputField({
    super.key,
    required this.hintText,
    required this.leftIconPath,
    required this.rightIconPath,
    required this.isShowRightIcon,
    required this.isShowLeftIcon,
  });
  final String hintText;
  final String leftIconPath;
  final String rightIconPath;
  final bool isShowRightIcon;
  final bool isShowLeftIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isShowRightIcon
              ? SvgPicture.asset(
                  leftIconPath,
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    AppColors.gray400,
                    BlendMode.srcIn,
                  ),
                )
              : const SizedBox.shrink(),

          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              cursorColor: AppColors.gray400,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: hintText,
                hintStyle: FontStyles.subTitle2.copyWith(
                  color: AppColors.gray400,
                ),
              ),
            ),
          ),

          isShowLeftIcon
              ? SvgPicture.asset(
                  rightIconPath,
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    AppColors.gray400,
                    BlendMode.srcIn,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
