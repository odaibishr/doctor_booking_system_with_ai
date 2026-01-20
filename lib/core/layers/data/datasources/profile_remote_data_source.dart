import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/porfile_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
    required File? imageFile,
    String? name,
    String? email,
    String? password,
  });
  Future<Profile> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioConsumer dioConsumer;

  ProfileRemoteDataSourceImpl(this.dioConsumer);
  @override
  Future<Profile> getProfile() async {
    final response = await dioConsumer.get('patients');
    return ProfileModel.fromJson(response['data']);
  }

  @override
  Future<Profile> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
    required File? imageFile,
    String? name,
    String? email,
    String? password,
  }) async {
    final Map<String, dynamic> data = {
      'phone': phone,
      'birth_date': birthDate,
      'gender': gender,
      'location_id': locationId,
    };

    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (password != null && password.isNotEmpty) data['password'] = password;

    if (imageFile != null) {
      data['profile_image'] = await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      );
    }

    final formData = FormData.fromMap(data);

    final response = await dioConsumer.post(
      '/patients',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    log("Create Profile response remote: $response");

    return ProfileModel.fromJson(response['data']);
  }
}
