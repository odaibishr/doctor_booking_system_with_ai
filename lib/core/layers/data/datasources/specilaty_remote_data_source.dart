import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/specialty_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';

abstract class SpecilatyRemoteDataSource {
  Future<List<Specialty>> getSpecialties();
}

class SpecilatyRemoteDataSourceImpl implements SpecilatyRemoteDataSource {
  final DioConsumer _dioConsumer;

  SpecilatyRemoteDataSourceImpl(this._dioConsumer);

  @override
  Future<List<Specialty>> getSpecialties() async {
    final response = await _dioConsumer.get('specialty/index');

    final specialties = <Specialty>[];

    final data = response['data'];
    final list = data is List ? data : const <dynamic>[];

    for (final item in list) {
      if (item is Map<String, dynamic>) {
        specialties.add(SpecialtyModel.fromMap(item));
      } else if (item is Map) {
        specialties.add(
          SpecialtyModel.fromMap(
            item.map((key, value) => MapEntry(key?.toString() ?? '', value)),
          ),
        );
      }
    }

    return specialties;
  }
}
