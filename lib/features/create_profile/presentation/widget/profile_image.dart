// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/widgets/profile_summary.dart';

class ProfileImage extends StatefulWidget {
  final Function(File?) onImageSelected;

  const ProfileImage({super.key, required this.onImageSelected});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (!mounted) return;
      setState(() {
        _selectedImage = File(pickedFile.path);
        log("Selected image path: ${_selectedImage?.path}");
        widget.onImageSelected(_selectedImage);
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم اختيار الصورة بنجاح ✅')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProfileSummary(
          name: '',
          userImage: _selectedImage != null
              ? _selectedImage!.path
              : 'assets/images/profile_image.png',
          phoneNumber: '',
        ),
        Positioned(
          bottom: 65,
          right: 12,
          child: GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.primaryColor,
              child: Icon(Icons.edit_outlined, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
