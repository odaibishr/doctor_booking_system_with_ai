import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/section_header.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/doctor_header_section.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/doctor_services_section.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/doctor_stats_section.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/patient_review_slider.dart';
import 'package:flutter/material.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: CustomAppBar(
              userImage: 'assets/images/user.png',
              title: 'معلومات الطبيب',
              isBackButtonVisible: true,
              isUserImageVisible: false,
              isHeartIconVisible: true,
            ),
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                DoctorHeaderSection(
                  doctorName: 'د. ${doctor.name}',
                  doctorSpecializatioin: doctor.specialty.name,
                  doctorLocation: doctor.location.name,
                  doctorImage: '${EndPoints.photoUrl}/${doctor.profileImage}',
                ),
                const SizedBox(height: 16),
                DoctorStatsSection(),
                const SizedBox(height: 22),

                // Doctor Description
                Text(
                  'نبذة عن الدكتور',
                  style: FontStyles.subTitle2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  doctor.aboutus,
                  style: FontStyles.body2.copyWith(color: AppColors.gray500),
                ),
                // End Doctor Description
                const SizedBox(height: 16),
                DoctorServicesSection(
                  doctorServices: doctor.services.split('.'),
                ),
                const SizedBox(height: 3),
                SectionHeader(title: 'المراجعات', onTap: () {}),
                const SizedBox(height: 2),
                const PatientReviewSlider(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
