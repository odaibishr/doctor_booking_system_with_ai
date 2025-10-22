import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;

  final FormFieldValidator<String>? validator;

  const PasswordField({
    Key? key,
    this.controller,
    this.hintText = 'أدخل كلمة المرور',
    
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  // يتحكم فيما إذا كانت كلمة المرور مخفية أم لا
  bool _obscure = true;

  // أيقونة حسب الحالة
  IconData get _visibilityIcon =>
      _obscure ? Icons.visibility_off : Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: widget.controller,
      obscureText: _obscure, // يخفي/يظهر النص
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      validator: widget.validator,
      decoration: InputDecoration(
        
       
        hintText: widget.hintText,
        // أيقونة على الجانب الأيمن قابلة للضغط لتغيير الحالة
        suffixIcon: IconButton(
          icon: Icon(_visibilityIcon,color: AppColors.primary,),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
          tooltip: _obscure ? 'إظهار كلمة المرور' : 'إخفاء كلمة المرور',
        ),
          prefixIcon:Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(Icons.lock_outline_rounded,color: AppColors.primary,size: 22,),
          ),
      
          
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.gray400)),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color:  AppColors.primary,width: 2)
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 1410, vertical: 8),
      ),
    );
  }
}
