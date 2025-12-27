import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class PatientReview extends StatelessWidget {
  const PatientReview({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    this.review,
  });
  final String imageUrl;
  final String name;
  final int rating;
  final String? review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: context.gray100Color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.gray300Color),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('${EndPoints.photoUrl}/$imageUrl'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: FontStyles.body2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.blackColor,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            Icons.star,
                            color: context.yellowColor,
                            size: 15,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            rating.toString(),
                            style: FontStyles.body2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.blackColor,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  review ?? '',
                  style: FontStyles.body3.copyWith(color: context.gray600Color),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
