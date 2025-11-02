import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
