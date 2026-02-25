
import 'dart:io';

import 'package:doctor_booking_system_with_ai/features/ai_chat/data/data_sources/ai_image_service.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/bottomsheet_items.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';


class BottomSheetModel extends StatefulWidget {
  const BottomSheetModel({
    super.key,
    required ImagePicker picker,
    required this.widget, required this.onSend,
  }) : _picker = picker;

  final ImagePicker _picker;
  final UploadButton widget;
  final Function({String? text, File? image}) onSend;

  @override
  State<BottomSheetModel> createState() => _BottomSheetModelState();
}

class _BottomSheetModelState extends State<BottomSheetModel> {
Future<void> _pickImage(ImageSource source) async {
  final XFile? pickedFile =
      await widget._picker.pickImage(source: source, imageQuality: 70);

  if (pickedFile == null) return;

  final File file = File(pickedFile.path);

  // أرسل الصورة فقط
  widget.onSend(image: file);
}

Future<void> _openLink(String url) async {
  final Uri uri = Uri.parse(url);

  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

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
                  // _openLink('https://huggingface.co/spaces/Aosldofdos/XrayModel');
                   _pickImage(ImageSource.camera);
                   Navigator.pop(context);
                  // final XFile? photo = await _picker.pickImage(
                  //   source: ImageSource.camera,
                  // );
                  // if (photo != null) {
                  //   widget.onSend(image: File(photo.path));
                  // }
                },
              ),
              BottomSheetItems(
                icons: 'assets/icons/gallery.svg',
                title: 'المعرض',
                ontap: () async {
                  // _openLink('https://huggingface.co/spaces/Aosldofdos/XrayModel');
                   _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                  // final XFile? image = await _picker.pickImage(
                  //   source: ImageSource.gallery,
                  // );
                  // if (image != null) {
                  //   widget.onSend(image: File(image.path));
                  // }
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
