import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/section_header.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor_details/doctor_details_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/details_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/doctor_header_section.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/doctor_services_section.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/doctor_stats_section.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/patient_review_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsViewBody extends StatefulWidget {
  const DetailsViewBody({super.key, required this.doctorId});
  final int doctorId;

  @override
  State<DetailsViewBody> createState() => _DetailsViewBodyState();
}

class _DetailsViewBodyState extends State<DetailsViewBody> {
  Doctor? doctor;
  @override
  void initState() {
    super.initState();
    context.read<DoctorDetailsCubit>().getDoctorsDetails(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
      builder: (context, state) {
        if (state is DoctorDetailsError) {
          return Center(
            child: Text(
              state.message,
              style: FontStyles.body3.copyWith(color: AppColors.error),
            ),
          );
        } else if (state is DoctorDetailsLoaded) {
          doctor = state.doctor;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: DetailsAppBar(
                  title: 'معلومات الطبيب',
                  doctorId: doctor!.id,
                ),
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.white,
                surfaceTintColor: AppColors.white,
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // const SizedBox(height: 30),
                    DoctorHeaderSection(
                      doctorName: 'د. ${doctor!.name}',
                      doctorSpecializatioin: doctor!.specialty.name,
                      doctorLocation: doctor!.location.name,
                      doctorImage:
                          '${EndPoints.photoUrl}/${doctor!.profileImage}',
                    ),

                    const SizedBox(height: 16),
                    DoctorStatsSection(),
                    const SizedBox(height: 22),

                    Text(
                      'نبذة عن الدكتور',
                      style: FontStyles.subTitle2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      doctor!.aboutus,
                      style: FontStyles.body2.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),

                    const SizedBox(height: 16),

                    DoctorServicesSection(
                      doctorServices: doctor!.services
                          .replaceAll('\n', "")
                          .split('.'),
                    ),

                    const SizedBox(height: 3),
                    SectionHeader(title: 'المراجعات', onTap: () {}),
                    const SizedBox(height: 2),

                    const PatientReviewSlider(),
                    const SizedBox(height: 16),
                  ]),
                ),
              ),
            ],
          );
        }
        return const CustomLoader(loaderSize: kLoaderSize);
      },
    );
  }
}
