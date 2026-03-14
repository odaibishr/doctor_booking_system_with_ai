import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_schedule_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_schedule_state.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/edit_schedule_view.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/widget/schedule_read_view.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorScheduleView extends StatefulWidget {
  const DoctorScheduleView({super.key});

  @override
  State<DoctorScheduleView> createState() => _DoctorScheduleViewState();
}

class _DoctorScheduleViewState extends State<DoctorScheduleView> {
  bool _hasLoadedOnce = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<DoctorScheduleCubit>()..fetchAll(),
      child: BlocConsumer<DoctorScheduleCubit, DoctorScheduleState>(
        listener: (context, state) {
          if (state is DoctorScheduleError) {
            context.showErrorToast(state.message);
          }
          if (state is DoctorScheduleLoaded) {
            if (_hasLoadedOnce) {
              context.showSuccessToast('تم تعديل جدول المواعيد بنجاح');
            }
            _hasLoadedOnce = true;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: const SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: CustomAppBar(
                    title: 'جدول المواعيد',
                    isBackButtonVisible: true,
                    isUserImageVisible: false,
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: state is DoctorScheduleLoaded
                ? FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _openEditView(context, state),
                    backgroundColor: context.primaryColor,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.edit_calendar_rounded,
                      color: Colors.white,
                    ),
                  )
                : null,
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, DoctorScheduleState state) {
    if (state is DoctorScheduleLoading) {
      return const Center(child: CustomLoader(loaderSize: kLoaderSize));
    }

    if (state is DoctorScheduleLoaded) {
      return ScheduleReadView(state: state);
    }

    return const SizedBox.shrink();
  }

  void _openEditView(BuildContext context, DoctorScheduleLoaded state) {
    final cubit = context.read<DoctorScheduleCubit>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: EditScheduleView(initialState: state),
        ),
      ),
    );
  }
}
