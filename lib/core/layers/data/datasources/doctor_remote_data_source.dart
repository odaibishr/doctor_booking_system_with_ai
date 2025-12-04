import 'dart:developer';

import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/doctor_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

abstract class DoctorRemoteDataSource {
  Future<List<Doctor>> getDoctors();
  Future<Doctor> getDoctorDetails(int id);
  Future<List<Doctor>> searchDoctors(String query);
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
  Future<List<Doctor>> searchDoctors(String query) async {
    final response = await dioConsumer.get(
      'doctor/getSearchDoctors/?query=$query',
    );

    final doctors = <Doctor>[];
    for (var doctor in response['data']) {
      doctors.add(DoctorModel.fromMap(doctor));
    }

    return doctors;
  }
}
