import 'dart:developer';

import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/data/models/porfile_model.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/entities/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioConsumer dioConsumer;
  @override
  Future<Profile> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
  }) async{
    final response = await dioConsumer.post(
      'profile',
      data: {
        'phone': phone,
        'birth_date': birthDate,
        'gender': gender,
        'location_id': locationId,
      }
    );

    log("Create Profile response: $response");

    return ProfileModel.fromJson(response);    
  }
}
