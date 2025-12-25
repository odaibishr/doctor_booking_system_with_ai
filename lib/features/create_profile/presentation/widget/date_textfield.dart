import 'package:date_field/date_field.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class DateTextField extends StatefulWidget {
  final Function(DateTime? date) onchanged;
  const DateTextField({super.key, required this.onchanged});

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      decoration: InputDecoration(
        labelText: 'تاريخ الميلاد',
        labelStyle: TextStyle(color: AppColors.gray400),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: const SizedBox.shrink(),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/calendar.svg',
            width: 18,
            height: 18,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
        ),
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      onChanged: widget.onchanged,
    );
  }
}
