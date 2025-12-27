import 'dart:io';

import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/bottomsheet_items.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetModel extends StatelessWidget {
  const BottomSheetModel({
    super.key,
    required ImagePicker picker,
    required this.widget,
  }) : _picker = picker;

  final ImagePicker _picker;
  final UploadButton widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomSheetItems(
                icons: 'assets/icons/camera.svg',
                title: 'الكاميرا',
                ontap: () async {
                  Navigator.pop(context);
                  final XFile? photo = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (photo != null) {
                    widget.onSend(image: File(photo.path));
                  }
                },
              ),
              BottomSheetItems(
                icons: 'assets/icons/gallery.svg',
                title: 'المعرض',
                ontap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    widget.onSend(image: File(image.path));
                  }
                },
              ),
              BottomSheetItems(
                icons: 'assets/icons/folder.svg',
                title: 'الملفات',
                ontap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
