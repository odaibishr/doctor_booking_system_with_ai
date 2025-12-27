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
  bool _obscure = true;

  IconData get _visibilityIcon =>
      _obscure ? Icons.visibility_off : Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: context.gray400Color,
      obscureText: _obscure,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: context.gray400Color),
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.lock_outline_rounded,
            color: context.primaryColor,
            size: 22,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(_visibilityIcon, color: context.primaryColor),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
          tooltip: _obscure ? 'إظهار كلمة المرور' : 'إخفاء كلمة المرور',
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.errorColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.errorColor, width: 2),
        ),
      ),
    );
  }
}
