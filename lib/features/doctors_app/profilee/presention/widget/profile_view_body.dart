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
                        const SizedBox(height: 32),
                        _buildMenuItem(
                          context,
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
                        _buildMenuItem(
                          context,
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
                        _buildMenuItem(
                          context,
                          title: 'المظهر',
                          icon: 'assets/icons/setting-2.svg',
                          onTap: () => ThemeModeSelector.show(context),
                        ),
                        const SizedBox(height: 12),
                        _buildMenuItem(
                          context,
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

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required String icon,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive
        ? AppColors.error
        : AppColors.getPrimary(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.getGray100(context),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 18,
                  height: 18,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: FontStyles.subTitle2.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, dynamic doctor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imageUrl = doctor.profileImage;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    final resolvedUrl = hasImage
        ? (imageUrl.startsWith('http')
              ? imageUrl
              : '${EndPoints.photoUrl}/$imageUrl')
        : '';

    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          backgroundImage: hasImage
              ? CachedNetworkImageProvider(resolvedUrl)
              : null,
          child: hasImage
              ? null
              : const Icon(Icons.person, size: 50, color: AppColors.primary),
        ),
        const SizedBox(height: 14),
        Text(
          doctor.name,
          style: FontStyles.headLine4.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: isDark ? AppColors.textPrimaryDark : AppColors.black,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          doctor.specialty.name,
          style: FontStyles.subTitle2.copyWith(
            color: isDark ? AppColors.textSecondaryDark : AppColors.gray400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          doctor.hospital.name,
          style: FontStyles.subTitle3.copyWith(
            color: isDark ? AppColors.textSecondaryDark : AppColors.gray500,
          ),
        ),
      ],
    );
  }
}
