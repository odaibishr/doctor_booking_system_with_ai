import 'dart:developer';
import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/features/notification/data/models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({int page = 1});
  Future<void> markAsRead(int id);
  Future<void> markAllAsRead();
  Future<int> getUnreadCount();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioConsumer _dioConsumer;

  NotificationRemoteDataSourceImpl(this._dioConsumer);

  @override
  Future<List<NotificationModel>> getNotifications({int page = 1}) async {
    final response = await _dioConsumer.get(
      'notification/index',
      queryParameters: {'page': page, 'per_page': 20},
    );

    final data = response['data'] as Map<String, dynamic>;
    final items = data['data'] as List<dynamic>;

    return items
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> markAsRead(int id) async {
    await _dioConsumer.put('notification/mark-read/$id');
  }

  @override
  Future<void> markAllAsRead() async {
    await _dioConsumer.put('notification/mark-all-read');
  }

  @override
  Future<int> getUnreadCount() async {
    final response = await _dioConsumer.get('notification/unread-count');
    log('Unread count response: $response');
    return (response['data']['count'] as int?) ?? 0;
  }
}
