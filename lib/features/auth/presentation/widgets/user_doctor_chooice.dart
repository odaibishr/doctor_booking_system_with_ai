import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svg_flutter/svg.dart';

class UserDoctorChooice extends StatelessWidget {
  final double imageWidth;
  final double imageheight;
  final String title;
  final VoidCallback onTapFun;
  final String image;
  final int index;
  final int selectedIndex;
  const UserDoctorChooice({
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
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.symmetric(horizontal: 55, vertical: 7),
        decoration: BoxDecoration(
          color: (selectedIndex == index)
              ? context.primaryColor
              : context.cardBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              image,
              width: imageWidth,
              height: imageheight,
              colorFilter: ColorFilter.mode(
                selectedIndex == index
                    ? context.whiteColor
                    : context.gray600Color,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                color: selectedIndex == index
                    ? context.whiteColor
                    : context.gray600Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
