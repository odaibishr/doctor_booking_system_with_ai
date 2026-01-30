import 'package:doctor_booking_system_with_ai/core/layers/data/models/hospital_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/specialty_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/models/user_model.dart';
import 'doctor_schedule_model.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    required super.id,
    required super.aboutus,
    required super.specialtyId,
    required super.hospitalId,
    required super.isFeatured,
    required super.isTopDoctor,
    required super.services,
    required super.specialty,
    required super.hospital,
    required super.isFavorite,
    required super.user,
    required super.price,
    required super.experience,
    super.schedules,
    super.newPatientDuration = 30,
    super.returningPatientDuration = 15,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> data) {
    final userMapRaw = data['user'];
    final userMap = userMapRaw is Map
        ? ensureMap(userMapRaw)
        : <String, dynamic>{};
    final user = userMap.isNotEmpty
        ? UserModel.fromJson(userMap)
        : UserModel.fromJson(ensureMap(data));

    return DoctorModel(
      id: parseToInt(data['id']),
      aboutus: (data['aboutus'] ?? data['about_us'] ?? '').toString(),
      specialtyId: parseToInt(data['specialty_id'] ?? data['specialtyId']),
      hospitalId: parseToInt(data['hospital_id'] ?? data['hospitalId']),
      isFeatured: parseToInt(data['is_featured'] ?? data['isFeatured']),
      isTopDoctor: parseToInt(data['is_top_doctor'] ?? data['isTopDoctor']),
      services: _parseServices(data['services']),
      specialty: data['specialty'] is Map
          ? SpecialtyModel.fromMap(ensureMap(data['specialty']))
          : SpecialtyModel.empty(),
      hospital: data['hospital'] is Map
          ? HospitalModel.fromMap(ensureMap(data['hospital']))
          : HospitalModel.empty(),
      isFavorite: parseToInt(data['is_favorite'] ?? data['isFavorite']),
      user: user,
      price: parseToDouble(data['price']),
      experience: parseToInt(data['experience']),
      schedules: data['schedules'] is List
          ? (data['schedules'] as List)
                .map<DoctorSchedule>((e) => DoctorScheduleModel.fromMap(e))
                .toList()
          : null,
      newPatientDuration: parseToInt(
        data['new_patient_duration'] ?? data['newPatientDuration'] ?? 30,
      ),
      returningPatientDuration: parseToInt(
        data['returning_patient_duration'] ??
            data['returningPatientDuration'] ??
            15,
      ),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'aboutus': aboutus,
    'specialty_id': specialtyId,
    'hospital_id': hospitalId,
    'is_featured': isFeatured,
    'is_top_doctor': isTopDoctor,
    'services': services,
    'specialty': specialty,
    'hospital': hospital,
    'is_favorite': isFavorite,
    'user': user,
    'price': price,
    'experience': experience,
    'schedules': schedules,
    'new_patient_duration': newPatientDuration,
    'returning_patient_duration': returningPatientDuration,
  };

  static List<String> _parseServices(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) {
      return raw.map((e) => e.toString()).where((s) => s.isNotEmpty).toList();
    }
    if (raw is String) {
      if (raw.isEmpty) return [];
      return raw
          .replaceAll('\n', '')
          .split('.')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    }
    return [];
  }
}
