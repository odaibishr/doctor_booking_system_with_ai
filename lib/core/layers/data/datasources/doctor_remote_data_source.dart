import 'dart:developer';

import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/doctor_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/schedule_capacity_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

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
    final data = response['data'];

    if (data is bool) return data;
    if (data is num) return data != 0;
    if (data is String) {
      final normalized = data.toLowerCase();
      if (normalized == 'true' || normalized == '1') return true;
      if (normalized == 'false' || normalized == '0') return false;
    }

    return true;
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
}
