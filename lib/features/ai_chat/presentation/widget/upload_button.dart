import 'dart:io';
import 'package:doctor_booking_system_with_ai/features/ai_chat/data/data_sources/ai_image_service.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/bottomsheet_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svg_flutter/svg_flutter.dart';

class UploadButton extends StatefulWidget {
  final Function({String? text, File? image}) onSend;
  const UploadButton({super.key, required this.onSend});

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  final ImagePicker _picker = ImagePicker();
  
  @override
  Widget build(BuildContext context) {
    Future<void> openSheet() async {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheetModel(picker: _picker, widget: widget, onSend:widget.onSend,);
          
        },
      );
    }

    return GestureDetector(
      onTap: () {
        openSheet();
        
      },
      child: Container(
        width: 33,
        height: 33,
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1000),
        ),
        child: SvgPicture.asset(
          'assets/icons/upload_menu_button.svg',
          width: 24,
          height: 24,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
