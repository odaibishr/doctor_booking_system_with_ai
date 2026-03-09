import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/notification/presentation/manager/notification_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/notification/presentation/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({super.key});

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomAppBar(
                  title: 'الإشعارات',
                  isBackButtonVisible: true,
                  isUserImageVisible: false,
                ),
              ),
              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoaded && state.unreadCount > 0) {
                    return TextButton(
                      onPressed: () {
                        context.read<NotificationCubit>().markAllAsRead();
                      },
                      child: Text(
                        'قراءة الكل',
                        style: TextStyle(
                          color: AppColors.getPrimary(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoading) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.getPrimary(context),
                      size: 40,
                    ),
                  );
                }

                if (state is NotificationError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 50,
                          color: AppColors.getGray400(context),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'فشل تحميل الإشعارات',
                          style: TextStyle(
                            color: AppColors.getGray600(context),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => context
                              .read<NotificationCubit>()
                              .fetchNotifications(),
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is NotificationLoaded) {
                  if (state.notifications.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 60,
                            color: AppColors.getGray400(context),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'لا توجد إشعارات',
                            style: TextStyle(
                              color: AppColors.getGray600(context),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () =>
                        context.read<NotificationCubit>().fetchNotifications(),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = state.notifications[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: MedicalNotificationCard(
                            notification: notification,
                            onTap: () {
                              if (!notification.isRead) {
                                context.read<NotificationCubit>().markAsRead(
                                  notification.id,
                                );
                              }
                            },
                          ),
                        );
                      },
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
}
