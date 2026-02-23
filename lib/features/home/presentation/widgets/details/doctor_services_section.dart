import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class DoctorServicesSection extends StatelessWidget {
  const DoctorServicesSection({super.key, required this.doctorServices});
  final List<String> doctorServices;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الخدمات',
          style: FontStyles.subTitle2.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Column(
          children: [
            doctorServices.isEmpty
                ? Center(
                    child: Text(
                      'لم يتم اضافة خدمات',
                      style: FontStyles.body2.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      for (var service in doctorServices)
                        Row(
                          children: [
                            Icon(Icons.circle, size: 10),
                            const SizedBox(width: 7),
                            Text(
                              service,
                              style: FontStyles.body2.copyWith(
                                color: AppColors.gray500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
            const SizedBox(height: 5),
          ],
        ),
      ],
    );
  }
}
