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
    this.controller,
    this.validator,
    this.isNumber,
    this.readonly,
    this.iconOnTap,
    this.onChanged,
    this.border= AppColors.primary,
  });

  final FormFieldValidator<String>? validator;
  final String hintText;
  final String leftIconPath;
  final String rightIconPath;
  final bool isShowRightIcon;
  final bool isShowLeftIcon;
  final bool? isNumber;
  final bool? readonly;
  final VoidCallback? iconOnTap;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly ?? false,
      onChanged: onChanged,
      keyboardType: (isNumber == true)
          ? TextInputType.numberWithOptions()
          : TextInputType.text,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: AppColors.gray400,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: FontStyles.subTitle2.copyWith(color: AppColors.gray400),
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        prefixIcon: isShowRightIcon
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  leftIconPath,
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : null,
        suffixIcon: isShowLeftIcon
            ? GestureDetector(
                onTap: iconOnTap,

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    rightIconPath,
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                    colorFilter: const ColorFilter.mode(
                      AppColors.gray400,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color:border ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color:border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: border, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),
    );
  }
}
