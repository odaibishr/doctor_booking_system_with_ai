import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';

abstract class SpecialtyLocalDataSource {
  Future<void> cachedSpecialties(List<Specialty> specialties);
  Future<List<Specialty>> getSpecialties();
}

class SpecialtyLocalDataSourceImpl implements SpecialtyLocalDataSource {
  @override
  Future<void> cachedSpecialties(List<Specialty> specialties) {
    // TODO: implement cachedSpecialties
    throw UnimplementedError();
  }

  @override
  Future<List<Specialty>> getSpecialties() {
    // TODO: implement getSpecialties
    throw UnimplementedError();
  }

}