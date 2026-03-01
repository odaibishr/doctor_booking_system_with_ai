import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svg_flutter/svg.dart';

class user_doctor_chooice extends StatelessWidget {
  final double imageWidth;
  final double imageheight;
  final String title;
  final VoidCallback onTapFun;
  final String image;
  final int index;
  final int selectedIndex;
  const user_doctor_chooice({
    super.key,
    required this.onTapFun,
    required this.image,
    required this.imageWidth,
    required this.imageheight,
    required this.title,
    required this.index,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFun,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 55, vertical: 7),
        child: Column(
          children: [
            SvgPicture.asset(
              image,
              width: imageWidth,
              height: imageheight,
              colorFilter: ColorFilter.mode(selectedIndex==index?AppColors.primary:Colors.black, BlendMode.srcIn),
            ),
            SizedBox(height: 5),
            Text(title, style: TextStyle(color: selectedIndex==index?AppColors.primary:Colors.black)),
          ],
        ),
        decoration: BoxDecoration(
          color:(selectedIndex == index)? const Color.fromARGB(255, 255, 255, 255):AppColors.gray300,
          border: (selectedIndex == index)
              ? Border.all(width: 2,color: AppColors.primary)
              : Border.all(color: AppColors.gray200),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
    );
  }
}
