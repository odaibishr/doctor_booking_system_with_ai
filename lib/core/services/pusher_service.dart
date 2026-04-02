import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  static final PusherService _instance = PusherService._internal();

  factory PusherService() => _instance;

  PusherService._internal();

  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final _eventController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get eventStream => _eventController.stream;

  Future<void> init({
    required String apiKey,
    required String cluster,
    required String userId,
    String? doctorId,
    required String token,
  }) async {
    try {
      // Disconnect if already connected
      await disconnect();

      // Resolve the broadcaster auth URL
      final authUrl = EndPoints.baseUrl.replaceFirst('/api/v1/', '/broadcasting/auth');

      await pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onEvent: (event) {
          log("[PUSHER] Event Received: ${event.eventName} on channel ${event.channelName}");
          log("[PUSHER] Data: ${event.data}");
          
          // Accept both prefixed and non-prefixed names
          final isAppointmentEvent = event.eventName == 'appointment.updated' || 
                                     event.eventName == 'appointment.created' ||
                                     event.eventName.endsWith('.AppointmentStatusUpdated');

          if (isAppointmentEvent) {
            try {
              final data = jsonDecode(event.data);
              _eventController.add(data);
            } catch (e) {
              log("[PUSHER] JSON Parse Error: $e");
            }
          }
        },
        onAuthorizer: (channelName, socketId, options) async {
          log("Authenticating Pusher Channel: $channelName");
          try {
            final dio = Dio();
            final response = await dio.post(
              authUrl,
              data: {
                'socket_id': socketId,
                'channel_name': channelName,
              },
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Accept': 'application/json',
                },
              ),
            );
            
            // Laravel broadcasting auth returns a JSON with 'auth' key
            return jsonDecode(response.data.toString());
          } catch (e) {
            log("Pusher Auth Error: $e");
            return {"error": e.toString()};
          }
        },
      );

      log('[PUSHER] Subscribing to private-user.$userId');
      await pusher.subscribe(channelName: "private-user.$userId");
      if (doctorId != null && doctorId.isNotEmpty) {
        log('[PUSHER] Subscribing to private-doctor.$doctorId');
        await pusher.subscribe(channelName: "private-doctor.$doctorId");
      }
      await pusher.connect();
    } catch (error) {
      log('[PUSHER] Error initializing Pusher: $error');
    }
  }

  Future<void> disconnect() async {
    try {
      await pusher.disconnect();
    } catch (e) {
      log("Error disconnecting Pusher: $e");
    }
  }

  void dispose() {
    _eventController.close();
  }
}
