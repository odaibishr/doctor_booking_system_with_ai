import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password, String? fcm_token);
  Future<UserModel> signUp(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  );
  Future<void> logout(String token);
  Future<UserModel> signInWithGoogle({
    required String idToken,
    String? fcmToken,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioConsumer dioConsumer;

  AuthRemoteDataSourceImpl(this.dioConsumer);

  @override
  Future<UserModel> signIn(
    String email,
    String password,
    String? fcm_token,
  ) async {
    final response = await dioConsumer.post(
      'login',
      data: {'email': email, 'password': password, 'fcm_token': fcm_token},
    );

    log("Full response: $response");

    if (response == null ||
        response['user'] == null ||
        response['token'] == null) {
      throw Exception("Invalid response from server or token missing");
    }

    final userJson = response['user'] as Map<String, dynamic>;
    final token = response['token'] as String;

    return UserModel.fromJson({...userJson, 'token': token});
  }

  @override
  Future<UserModel> signUp(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    final response = await dioConsumer.post(
      'register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    log("Full response: $response");

    if (response == null ||
        response['user'] == null ||
        response['token'] == null) {
      throw Exception("Invalid response from server or token missing");
    }

    final userJson = response['user'] as Map<String, dynamic>;
    final token = response['token'] as String;

    return UserModel.fromJson({...userJson, 'token': token});
  }

  @override
  Future<void> logout(String token) async {
    await dioConsumer.post(
      'logout',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<UserModel> signInWithGoogle({
    required String idToken,
    String? fcmToken,
  }) async {
    final response = await dioConsumer.post(
      'google-auth',
      data: {'id_token': idToken, 'fcm_token': fcmToken},
    );

    log("Google Sign in response: $response");

    if (response == null ||
        response['user'] == null ||
        response['token'] == null) {
      throw Exception("Invalid response from server or token missing");
    }

    final userJson = response['user'] as Map<String, dynamic>;
    final token = response['token'] as String;

    return UserModel.fromJson({...userJson, 'token': token});
  }
}
