import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/doctor_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/doctor_schedule_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';

abstract class DoctorProfileRemoteDataSource {
  Future<Doctor> getMyProfile();
  Future<Doctor> updateProfile(Map<String, dynamic> data);
  Future<String> updateProfileImage(File imageFile);
  Future<List<DoctorSchedule>> getSchedules();
  Future<DoctorSchedule> updateSchedule(
    int id,
    String startTime,
    String endTime,
  );
  Future<List<DoctorDayOff>> getDaysOff();
  Future<List<DoctorDayOff>> createDayOff(List<int> dayIds);
  Future<void> deleteDayOff(int id);
}

class DoctorProfileRemoteDataSourceImpl
    implements DoctorProfileRemoteDataSource {
  final DioConsumer dioConsumer;

  DoctorProfileRemoteDataSourceImpl(this.dioConsumer);

  @override
  Future<Doctor> getMyProfile() async {
    final response = await dioConsumer.get('doctor/profile');
    final data = ensureMap(response['data'] ?? response);
    return DoctorModel.fromMap(data);
  }

  @override
  Future<Doctor> updateProfile(Map<String, dynamic> data) async {
    final response = await dioConsumer.put('doctor/profile', data: data);
    final responseData = ensureMap(response['data'] ?? response);
    return DoctorModel.fromMap(responseData);
  }

  @override
  Future<String> updateProfileImage(File imageFile) async {
    final response = await dioConsumer.post(
      'doctor/profile/image',
      data: {'profile_image': await _multipartFile(imageFile)},
      isFormData: true,
    );
    final data = ensureMap(response['data'] ?? response);
    return data['profile_image']?.toString() ?? '';
  }

  @override
  Future<List<DoctorSchedule>> getSchedules() async {
    final response = await dioConsumer.get('doctor/my-schedules');
    final list = response['data'] as List? ?? [];
    return list
        .whereType<Map>()
        .map((e) => DoctorScheduleModel.fromMap(ensureMap(e)))
        .toList();
  }

  @override
  Future<DoctorSchedule> updateSchedule(
    int id,
    String startTime,
    String endTime,
  ) async {
    final response = await dioConsumer.put(
      'doctor/my-schedules/$id',
      data: {'start_time': startTime, 'end_time': endTime},
    );
    final data = ensureMap(response['data'] ?? response);
    return DoctorScheduleModel.fromMap(data);
  }

  @override
  Future<List<DoctorDayOff>> getDaysOff() async {
    final response = await dioConsumer.get('doctor/my-schedules/days-off');
    final list = response['data'] as List? ?? [];
    return list
        .whereType<Map>()
        .map((e) => DoctorDayOff.fromMap(ensureMap(e)))
        .toList();
  }

  @override
  Future<List<DoctorDayOff>> createDayOff(List<int> dayIds) async {
    final response = await dioConsumer.post(
      'doctor/my-schedules/days-off',
      data: {'day_id': dayIds},
    );
    final list = response['data'] as List? ?? [];
    return list
        .whereType<Map>()
        .map((e) => DoctorDayOff.fromMap(ensureMap(e)))
        .toList();
  }

  @override
  Future<void> deleteDayOff(int id) async {
    await dioConsumer.delete('doctor/my-schedules/days-off/$id');
  }

  Future<dynamic> _multipartFile(File file) async {
    final fileName = file.path.split(Platform.pathSeparator).last;
    return await MultipartFile.fromFile(file.path, filename: fileName);
  }
}
