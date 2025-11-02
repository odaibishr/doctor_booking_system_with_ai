import 'dart:io';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ChatTextField extends StatefulWidget {
  final Function({String? text, File? image}) onSend;
  const ChatTextField({
    super.key, required this.onSend,
  });

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  @override
  Widget build(BuildContext context) {
     final TextEditingController _controller = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: TextField(    
            controller: _controller,
            style: TextStyle(color: AppColors.gray100),
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.none,
            maxLines: null,
            decoration: InputDecoration(  
              hintText:'اوصف حالتك ...',
              hintStyle: FontStyles.subTitle2.copyWith(color: AppColors.gray400),
              isCollapsed: true,
              fillColor: AppColors.primary,
              contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              suffixIcon: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset('assets/icons/upload_menu_button.svg',fit:BoxFit.fill),
                ),
                onLongPress: () {
                  
                },
              ),
              
               border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              
            ),
          ),
        ),
        IconButton( icon:SvgPicture.asset('assets/icons/send_icon.svg',width: 58,) ,onPressed: () {
          if(_controller.text.isNotEmpty)
          {
            widget.onSend(text: _controller.text);
             print(_controller.text);
            _controller.clear();
         
          }
          
        },)
      ],
    );
  }
}
