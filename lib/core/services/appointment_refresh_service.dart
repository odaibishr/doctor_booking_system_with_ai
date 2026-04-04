import 'dart:async';
import 'dart:developer';

import 'package:doctor_booking_system_with_ai/core/services/fcm_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';

class AppointmentRefreshService {
  final PusherService _pusherService;
  final FcmService _fcmService;

  final _refreshController = StreamController<void>.broadcast();
  StreamSubscription<Map<String, dynamic>>? _pusherSub;
  StreamSubscription<Map<String, dynamic>>? _fcmSub;

  Stream<void> get refreshStream => _refreshController.stream;

  AppointmentRefreshService(this._pusherService, this._fcmService);

  void startListening() {
    _pusherSub?.cancel();
    _pusherSub = _pusherService.eventStream.listen((event) {
      log('[AppointmentRefreshService] Pusher event received: $event');
      _refreshController.add(null);
    });

    _fcmSub?.cancel();
    _fcmSub = _fcmService.eventStream.listen((data) {
      final type = data['type']?.toString();
      if (type == 'appointment_created' || type == 'appointment_updated') {
        log('[AppointmentRefreshService] FCM event received: $data');
        _refreshController.add(null);
      }
    });
  }

  void triggerRefresh() {
    _refreshController.add(null);
  }

  void dispose() {
    _pusherSub?.cancel();
    _fcmSub?.cancel();
    _refreshController.close();
  }
}
