import 'dart:io';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/widgets/profile_summary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم اختيار الصورة بنجاح ✅')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProfileSummary(
      name: '',
      userImage: _selectedImage != null
                    ? _selectedImage!.path : 'assets/images/profile_image.png',
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
              child: Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
