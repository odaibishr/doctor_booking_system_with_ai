import 'package:doctor_booking_system_with_ai/core/layers/data/models/hospital_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/specialty_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/models/user_model.dart';

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
  });

  factory DoctorModel.fromMap(Map<String, dynamic> data) {
    final userMapRaw = data['user'];
    final userMap = userMapRaw is Map ? _ensureMap(userMapRaw) : <String, dynamic>{};
    final user = userMap.isNotEmpty ? UserModel.fromJson(userMap) : UserModel.fromJson(_ensureMap(data));

    return DoctorModel(
      id: _toInt(data['id']),
      aboutus: (data['aboutus'] ?? data['about_us'] ?? '').toString(),
      specialtyId: _toInt(data['specialty_id'] ?? data['specialtyId']),
      hospitalId: _toInt(data['hospital_id'] ?? data['hospitalId']),
      isFeatured: _toInt(data['is_featured'] ?? data['isFeatured']),
      isTopDoctor: _toInt(data['is_top_doctor'] ?? data['isTopDoctor']),
      services: (data['services'] ?? '').toString(),
      specialty: data['specialty'] is Map
          ? SpecialtyModel.fromMap(_ensureMap(data['specialty']))
          : SpecialtyModel.empty(),
      hospital: data['hospital'] is Map
          ? HospitalModel.fromMap(_ensureMap(data['hospital']))
          : HospitalModel.empty(),
      isFavorite: _toInt(data['is_favorite'] ?? data['isFavorite']),
      user: user,
      price: _toDouble(data['price']),
      experience: _toInt(data['experience']),
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
      };

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse('${value ?? ''}') ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse('${value ?? ''}') ?? 0.0;
  }

  static Map<String, dynamic> _ensureMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }
}
