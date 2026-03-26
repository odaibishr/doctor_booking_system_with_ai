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
    String? fcm_token,
  );
  Future<void> logout(String token);
  Future<UserModel> signInWithGoogle({
    required String idToken,
    String? fcmToken,
  });
  Future<String> forgotPassword(String email);
  Future<String> verifyOtp(String email, String otp);
  Future<String> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
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
    String? fcm_token,
  ) async {
    final response = await dioConsumer.post(
      'register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'fcm_token': fcm_token,
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

  @override
  Future<String> forgotPassword(String email) async {
    final response = await dioConsumer.post(
      'password/forgot',
      data: {'email': email},
    );
    return response['message'];
  }

  @override
  Future<String> verifyOtp(String email, String otp) async {
    final response = await dioConsumer.post(
      'password/verify-otp',
      data: {'email': email, 'otp': otp},
    );
    return response['message'];
  }

  @override
  Future<String> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await dioConsumer.post(
      'password/reset',
      data: {
        'email': email,
        'otp': otp,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
    return response['message'];
  }
}

