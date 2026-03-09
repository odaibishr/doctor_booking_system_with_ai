import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_booking_system_with_ai/features/notification/domain/entities/notification_entity.dart';
import 'package:doctor_booking_system_with_ai/features/notification/domain/repos/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _repo;

  NotificationCubit(this._repo) : super(NotificationInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationLoading());
    final result = await _repo.getNotifications();
    result.fold((failure) => emit(NotificationError(failure.errorMessage)), (
      notifications,
    ) async {
      final countResult = await _repo.getUnreadCount();
      final unread = countResult.fold((_) => 0, (count) => count);
      emit(
        NotificationLoaded(notifications: notifications, unreadCount: unread),
      );
    });
  }

  Future<void> markAsRead(int id) async {
    final result = await _repo.markAsRead(id);
    result.fold((_) {}, (_) {
      if (state is NotificationLoaded) {
        final current = state as NotificationLoaded;
        final updated = current.notifications.map((n) {
          if (n.id == id) {
            return NotificationEntity(
              id: n.id,
              title: n.title,
              message: n.message,
              type: n.type,
              isRead: true,
              data: n.data,
              createdAt: n.createdAt,
            );
          }
          return n;
        }).toList();
        emit(
          current.copyWith(
            notifications: updated,
            unreadCount: (current.unreadCount - 1).clamp(
              0,
              current.unreadCount,
            ),
          ),
        );
      }
    });
  }

  Future<void> markAllAsRead() async {
    final result = await _repo.markAllAsRead();
    result.fold((_) {}, (_) {
      if (state is NotificationLoaded) {
        final current = state as NotificationLoaded;
        final updated = current.notifications.map((n) {
          return NotificationEntity(
            id: n.id,
            title: n.title,
            message: n.message,
            type: n.type,
            isRead: true,
            data: n.data,
            createdAt: n.createdAt,
          );
        }).toList();
        emit(current.copyWith(notifications: updated, unreadCount: 0));
      }
    });
  }

  Future<void> refreshUnreadCount() async {
    final result = await _repo.getUnreadCount();
    result.fold((_) {}, (count) {
      if (state is NotificationLoaded) {
        emit((state as NotificationLoaded).copyWith(unreadCount: count));
      }
    });
  }
}
