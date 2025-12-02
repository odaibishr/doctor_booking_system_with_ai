import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/features/home/data/models/specialty_model.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';

abstract class SpecilatyRemoteDataSource {
  Future<List<Specialty>> getSpecialties();
}

class SpecilatyRemoteDataSourceImpl implements SpecilatyRemoteDataSource {
  final DioConsumer _dioConsumer;

  SpecilatyRemoteDataSourceImpl(this._dioConsumer);

  @override
  Future<List<Specialty>> getSpecialties() async {
    final response = await _dioConsumer.get('specilaty/index');

    final specialties = <Specialty>[];

    for (var specialty in response['data']) {
      specialties.add(SpecialtyModel.fromMap(specialty));
    }

    return specialties;
  }
}
