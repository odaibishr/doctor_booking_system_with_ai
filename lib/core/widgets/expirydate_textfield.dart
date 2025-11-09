import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ExpiryDateField extends StatefulWidget {
  final Function(String month, String year)? onChanged;

  const ExpiryDateField({super.key, this.onChanged});

  @override
  State<ExpiryDateField> createState() => _ExpiryDateFieldState();
}

class _ExpiryDateFieldState extends State<ExpiryDateField> {
  final TextEditingController _controller = TextEditingController();
  String _month = '';
  String _year = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      maxLength: 5,
      decoration: InputDecoration(
        counterText: '',

        hintText: 'MM/YY',
       border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
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
      onChanged: (value) {
        value = value.replaceAll(RegExp(r'[^0-9/]'), '');

        if (value.length == 2 && !value.contains('/')) {
          value = '$value/';
        }

        _controller.value = TextEditingValue(
          text: value,
          selection: TextSelection.fromPosition(
            TextPosition(offset: value.length),
          ),
        );

        if (value.contains('/')) {
          final parts = value.split('/');
          _month = parts[0];
          _year = parts.length > 1 ? parts[1] : '';
          widget.onChanged?.call(_month, _year);
        }
      },
    );
  }
}
