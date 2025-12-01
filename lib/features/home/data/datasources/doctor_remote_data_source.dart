import 'dart:developer';

import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/features/home/data/models/doctor_model.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';

abstract class DoctorRemoteDataSource {
  Future<List<Doctor>> getDoctors();
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
}
