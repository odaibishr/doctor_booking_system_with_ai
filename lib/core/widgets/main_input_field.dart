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
    this.validator,
    this.is_number,

  });

  final FormFieldValidator<String>? validator;
  final String hintText;
  final String leftIconPath;
  final String rightIconPath;
  final bool isShowRightIcon;
  final bool isShowLeftIcon;
  final bool ?is_number;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      keyboardType:(is_number==true)?TextInputType.numberWithOptions():TextInputType.text,
      validator: validator,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: AppColors.gray400,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        hintStyle: FontStyles.subTitle2.copyWith(
          color: AppColors.gray400,
        ),
        prefixIcon: isShowRightIcon
        ? SvgPicture.asset(
            leftIconPath,
            width: 20,
            height: 20,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          )
        : const SizedBox.shrink(),
        suffixIcon: isShowLeftIcon
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        
      ),
    );
  }
}
