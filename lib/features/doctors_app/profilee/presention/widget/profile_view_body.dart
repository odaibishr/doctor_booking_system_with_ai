import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/confirm_action_dialog.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/theme_mode_selector.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_profile_state.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/edit_doctor_info_view.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/doctor_schedule_view.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/widget/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:svg_flutter/svg.dart';

class ProfileeViewBody extends StatelessWidget {
  const ProfileeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.scaffoldBackgroundDark
        : Colors.white;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state is AuthError) {
          context.showErrorToast(state.message);
        }
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: const CustomAppBar(
              title: 'الملف الشخصي',
              isBackButtonVisible: false,
              isUserImageVisible: false,
            ),
            pinned: true,
            backgroundColor: backgroundColor,
            surfaceTintColor: backgroundColor,
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
              builder: (context, state) {
                if (state is DoctorProfileLoading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(child: CustomLoader(loaderSize: kLoaderSize)),
                  );
                }

                if (state is DoctorProfileError) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(child: Text(state.message)),
                  );
                }

                if (state is DoctorProfileLoaded) {
                  final doctor = state.doctor;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildProfileHeader(context, doctor),
                        const SizedBox(height: 30),
                        MenuItem(
                          title: 'المعلومات الشخصية',
                          icon: 'assets/icons/user.svg',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EditDoctorInfoView(doctor: doctor),
                              ),
                            ).then((_) {
                              context.read<DoctorProfileCubit>().fetchProfile();
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        MenuItem(
                          title: 'جدول المواعيد والإجازات',
                          icon: 'assets/icons/calendar.svg',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DoctorScheduleView(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        MenuItem(
                          title: 'المظهر',
                          icon: 'assets/icons/setting-2.svg',
                          onTap: () => ThemeModeSelector.show(context),
                        ),
                        const SizedBox(height: 12),
                        MenuItem(
                          title: 'تسجيل الخروج',
                          icon: 'assets/icons/login.svg',
                          isDestructive: true,
                          onTap: () async {
                            final authCubit = context.read<AuthCubit>();
                            final confirmed = await ConfirmActionDialog.show(
                              context,
                              title: 'تسجيل الخروج',
                              message: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                              confirmText: 'نعم',
                              cancelText: 'لا',
                              icon: Icons.logout,
                              confirmColor: AppColors.error,
                            );
                            if (!context.mounted || !confirmed) return;
                            await authCubit.logout();
                            if (!context.mounted) return;
                            context.showSuccessToast('تم تسجيل الخروج بنجاح');
                          },
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, dynamic doctor) {
    final imageUrl = doctor.profileImage;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    final resolvedUrl = hasImage
        ? (imageUrl.startsWith('http')
              ? imageUrl
              : '${EndPoints.photoUrl}/$imageUrl')
        : '';

    const double avatarRadius = 55;
    const double overlapAmount = 30;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: avatarRadius - overlapAmount),
          padding: EdgeInsets.only(
            top: avatarRadius + overlapAmount + 10,
            bottom: 20,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: context.gray200Color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(
                  doctor.name,
                  style: FontStyles.subTitle1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.blackColor,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      doctor.specialty.name,
                      style: FontStyles.subTitle3.copyWith(
                        color: context.gray500Color,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 1,
                      height: 20,
                      color: context.gray600Color,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        doctor.hospital.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FontStyles.subTitle3.copyWith(
                          color: context.gray500Color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: CircleAvatar(
            radius: avatarRadius,
            backgroundColor: context.gray400Color,
            backgroundImage: hasImage
                ? CachedNetworkImageProvider(resolvedUrl)
                : null,
            child: hasImage
                ? null
                : const Icon(Icons.person, size: 50, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
