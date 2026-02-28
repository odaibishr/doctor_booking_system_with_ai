import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/doctor_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/doctor_schedule_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/schedule_capacity_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';

abstract class DoctorRemoteDataSource {
  Future<List<Doctor>> getDoctors();
  Future<Doctor> getDoctorDetails(int id);
  Future<List<Doctor>> searchDoctors(String query, int? specialtyId);
  Future<bool> toggleFavoriteDoctor(int doctorId);
  Future<List<Doctor>> getFavoriteDoctors();
  Future<ScheduleCapacity> getScheduleCapacity({
    required int doctorId,
    required int scheduleId,
    required String date,
  });

  Future<Doctor> getMyProfile();
  Future<Doctor> updateMyProfile(Map<String, dynamic> data);
  Future<String> updateMyProfileImage(File imageFile);
  Future<DoctorSchedule> getMySchedules();
  Future<DoctorSchedule> updateMySchedule(Map<String, dynamic> data, int id);
  Future<List<Map<String, dynamic>>> getMyDaysOff();
  Future<List<Map<String, dynamic>>> createMyDaysOff(List<int> daysId);
  Future<void> deleteMyDayOff(int id);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final DioConsumer dioConsumer;

  DoctorRemoteDataSourceImpl(this.dioConsumer);

  @override
  Future<List<Doctor>> getDoctors() async {
    log("Fetching doctors from remote data source");
    final response = await dioConsumer.get('doctor/AllDoctors');

    final doctors = <Doctor>[];
    for (var doctorJson in response['data']) {
      log(doctorJson.toString());
      doctors.add(DoctorModel.fromMap(doctorJson));
    }
    log("Fetched ${doctors.length} doctors from remote data source");
    return doctors;
  }

  @override
  Future<Doctor> getDoctorDetails(int id) async {
    final response = await dioConsumer.get('doctor/getDoctor/$id');

    return DoctorModel.fromMap(response['data']);
  }

  @override
  Future<List<Doctor>> searchDoctors(String query, int? specialtyId) async {
    log("sending Query: $query $specialtyId");
    final response = await dioConsumer.get(
      'doctor/getSearchDoctors',
      queryParameters: {'query': query, 'specialty_id': specialtyId},
    );

    log("Response from server: ${response.toString()}");

    final doctors = <Doctor>[];
    for (var doctor in response['data']) {
      doctors.add(DoctorModel.fromMap(doctor));
    }

    log("sending Query: $query $specialtyId");
    return doctors;
  }

  @override
  Future<bool> toggleFavoriteDoctor(int doctorId) async {
    final response = await dioConsumer.post(
      'favorite/toggle',
      data: {'doctor_id': doctorId},
    );
    log('Toggle favorite response: $response');
    final data = response['data'];
    log('Toggle favorite data: $data (type: ${data.runtimeType})');
    if (data is bool) return data;
    if (data is num) return data != 0;
    return data.toString().toLowerCase() == 'true';
  }

  @override
  Future<List<Doctor>> getFavoriteDoctors() async {
    final response = await getDoctors();

    return response.where((doctor) => doctor.isFavorite == 1).toList();
  }

  @override
  Future<ScheduleCapacity> getScheduleCapacity({
    required int doctorId,
    required int scheduleId,
    required String date,
  }) async {
    final response = await dioConsumer.get(
      'appointment/getScheduleCapacity',
      queryParameters: {
        'doctor_id': doctorId,
        'doctor_schedule_id': scheduleId,
        'date': date,
      },
    );

    return ScheduleCapacity.fromMap(response['data']);
  }

  @override
  Future<Doctor> getMyProfile() async {
    final response = await dioConsumer.get('doctor/profile');
    return DoctorModel.fromMap(response['data']);
  }

  @override
  Future<Doctor> updateMyProfile(Map<String, dynamic> data) async {
    final response = await dioConsumer.put('doctor/profile', data: data);
    return DoctorModel.fromMap(response['data']);
  }

  @override
  Future<String> updateMyProfileImage(File imageFile) async {
    final formData = FormData.fromMap({
      'profile_image': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split(Platform.pathSeparator).last,
      ),
    });

    final response = await dioConsumer.post(
      'doctor/profile/image',
      data: formData,
    );

    return (response['data']['profile_image'] ?? '').toString();
  }

  @override
  Future<DoctorSchedule> getMySchedules() async {
    final response = await dioConsumer.get('doctor/my-schedules');
    final data = response['data'];
    if (data is! List) {
      return DoctorScheduleModel.fromMap(data as Map<String, dynamic>);
    }

    return DoctorScheduleModel.fromMap(data as Map<String, dynamic>);
  }

  @override
  Future<DoctorSchedule> updateMySchedule(
    Map<String, dynamic> data,
    int id,
  ) async {
    final response = await dioConsumer.put(
      'doctor/my-schedules/$id',
      data: data,
    );

    return DoctorScheduleModel.fromMap(response['data']);
  }

  @override
  Future<List<Map<String, dynamic>>> getMyDaysOff() async {
    final response = await dioConsumer.get('doctor/my-schedules/days-off');
    final data = response['data'];

    if (data is! List) return [];

    return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> createMyDaysOff(List<int> daysId) async {
    final response = await dioConsumer.post(
      'doctor/my-schedules/days-off',
      data: {'day_id': daysId},
    );

    final data = response['data'];
    if (data is! List) return [];

    return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  @override
  Future<void> deleteMyDayOff(int id) async {
    await dioConsumer.delete('doctor/my-schedules/days-off/$id');
  }
}
