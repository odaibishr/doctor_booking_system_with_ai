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
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioConsumer dioConsumer;

  ProfileRemoteDataSourceImpl(this.dioConsumer);
  @override
  Future<Profile> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
    required File? imageFile,
  }) async {
    final formData = FormData.fromMap({
      'phone': phone,
      'birth_date': birthDate,
      'gender': gender,
      'location_id': locationId,
      if (imageFile != null)
        'profile_image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    final response = await dioConsumer.post(
      '/patients',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    log("Create Profile response remote: $response");

    return ProfileModel.fromJson(response['data']);
  }
}
