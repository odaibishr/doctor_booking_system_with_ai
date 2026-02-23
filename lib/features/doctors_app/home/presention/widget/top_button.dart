import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  final VoidCallback OnTap;
  final int SelectedIndex;
  final int Index;
  final String Title;
  const TopButton({
    super.key, required this.OnTap, required this.SelectedIndex, required this.Title, required this.Index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: 10,bottom: 10,left: 14,right: 14),
        child: Text(Title,
          style: TextStyle(color: AppColors.white),
        ),
        decoration: BoxDecoration(color:(SelectedIndex==Index)? AppColors.primaryColor:AppColors.gray400,
        borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
