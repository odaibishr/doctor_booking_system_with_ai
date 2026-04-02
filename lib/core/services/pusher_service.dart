import 'dart:convert';
import 'dart:developer';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  static final PusherService _instance = PusherService._internal();

  factory PusherService() => _instance;

  PusherService._internal();

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  Future<void> init({
    required String apiKey,
    required String cluster,
    required String userId,
    required String doctorId,
    required String token,
    required Function(dynamic) onEventReceived,
  }) async {
    try {
      await pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onEvent: (event) {
          log(
            "Pusher Event: ${event.eventName} with data: ${event.data}",
          );
          if (event.eventName == 'appointment.updated') {
            final data = jsonDecode(event.data);
            onEventReceived(data);
          }
        },
        onAuthorizer: (channelName, socketId, options) async {
          return {"auth": "your_auth_string"};
        },
      );
      await pusher.subscribe(channelName: "private-user.$userId");
      if (doctorId.isNotEmpty) {
        await pusher.subscribe(channelName: "private-doctor.$doctorId");
      }
      await pusher.connect();
    } catch (error) {
      log('Error initializing Pusher: $error');
    }
  }
}
