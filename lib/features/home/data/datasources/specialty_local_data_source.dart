import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class SpecialtyLocalDataSource {
  Future<void> cachedSpecialties(List<Specialty> specialties);
  Future<List<Specialty>> getSpecialties();
}

class SpecialtyLocalDataSourceImpl implements SpecialtyLocalDataSource {
  final Box<Specialty> specialtyBox;

  SpecialtyLocalDataSourceImpl(this.specialtyBox);

  @override
  Future<void> cachedSpecialties(List<Specialty> specialties) async {
    await specialtyBox.clear();
    for (final specialty in specialties) {
      await specialtyBox.put(specialty.id, specialty);
    }
  }

  @override
  Future<List<Specialty>> getSpecialties() {
    // TODO: implement getSpecialties
    throw UnimplementedError();
  }
}
