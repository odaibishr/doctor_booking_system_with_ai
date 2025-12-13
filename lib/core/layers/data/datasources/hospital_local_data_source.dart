import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HospitalLocalDataSource {
  Future<List<Hospital>> getCachedHospitals();
  Future<void> cachedHospitals(List<Hospital> hospitals);
}

class HospitalLocalDataSourceImpl implements HospitalLocalDataSource {
  final Box<Hospital> _hospitalBox;

    HospitalLocalDataSourceImpl(this._hospitalBox);

  @override
  Future<List<Hospital>> getCachedHospitals() async {
    return _hospitalBox.values.toList();
  }

  @override
  Future<void> cachedHospitals(List<Hospital> hospitals) async {
    await _hospitalBox.clear();

    for (final hospital in hospitals) {
      await _hospitalBox.put(hospital.id, hospital);
    }
  }
}
