import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;

  final FormFieldValidator<String>? validator;

  const PasswordField({
    super.key,
    this.controller,
    this.hintText = 'أدخل كلمة المرور',

    this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  // controls whether the password is hidden or not
  bool _obscure = true;

  // icon based on the state
  IconData get _visibilityIcon =>
      _obscure ? Icons.visibility_off : Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: AppColors.gray400,
      obscureText: _obscure, // controls whether the password is hidden or not
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        // icon on the right side that can be pressed to change the state
        suffixIcon: IconButton(
          icon: Icon(_visibilityIcon, color: AppColors.gray400),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
          tooltip: _obscure ? 'إظهار كلمة المرور' : 'إخفاء كلمة المرور',
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Icon(
            Icons.lock_outline_rounded,
            color: AppColors.gray400,
            size: 22,
          ),
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.gray400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: AppColors.gray400, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 1410,
          vertical: 12,
        ),
      ),
    );
  }
}
