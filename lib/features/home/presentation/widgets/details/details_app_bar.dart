import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({super.key, required this.title, required this.doctorId});
  final String title;
  final int doctorId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocConsumer(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            return GestureDetector(
              onTap: () => {},
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary),
                ),
                child: ClipOval(
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: AppColors.primary,
                  ),
                ),
              ),
            );
          },
        ),
        Text(
          title,
          style: FontStyles.headLine4.copyWith(fontWeight: FontWeight.bold),
        ),

        const BackButton(),
      ],
    );
  }
}
