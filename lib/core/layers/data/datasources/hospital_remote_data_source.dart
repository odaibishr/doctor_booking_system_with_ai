import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/hospital_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';

abstract class HospitalRemoteDataSource {
  Future<List<Hospital>> getHospitals();
}

class HospitalRemoteDataSourceImpl implements HospitalRemoteDataSource {
  final DioConsumer _dioConsumer;

  HospitalRemoteDataSourceImpl(this._dioConsumer);

  @override
  Future<List<Hospital>> getHospitals() async {
    final response = await _dioConsumer.get('hospital/getAllHospitals');

    final hospitals = <Hospital>[];

    if (response['data'] != null) {
      for (var hospital in response['data']) {
        hospitals.add(HospitalModel.fromMap(hospital));
      }
    }

    return hospitals;
  }
}
