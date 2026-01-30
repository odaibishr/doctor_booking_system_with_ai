import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SafeDoctorAdapter extends TypeAdapter<Doctor> {
  @override
  final int typeId = 2;

  @override
  Doctor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    // Support both current layout (user at field 10) and old layout (name/email/...)
    final hasUser = fields[10] is User;

    final int id = parseToInt(fields[0]);

    final int specialtyId = parseToInt(_pick(fields, primary: 2, legacy: 6));
    final int hospitalId = parseToInt(_pick(fields, primary: 3, legacy: 7));
    final int isFeatured = parseToInt(_pick(fields, primary: 4, legacy: 9));
    final int isTopDoctor = parseToInt(_pick(fields, primary: 5, legacy: 10));
    final dynamic rawServices = _pick(fields, primary: 6, legacy: 13);
    final List<String> services = _parseServices(rawServices);

    final specialtyValue =
        _asSpecialty(_pick(fields, primary: 7, legacy: 15)) ??
        Specialty(id: 0, name: '', icon: '', isActive: false);
    final hospitalValue =
        _asHospital(_pick(fields, primary: 8, legacy: 16)) ??
        Hospital(
          id: 0,
          name: '',
          phone: '',
          email: '',
          website: '',
          address: '',
          image: '',
          locationId: 0,
          doctors: null,
        );

    final int isFavorite = parseToInt(_pick(fields, primary: 9, legacy: 17));

    final double price = parseToDouble(fields[11]);
    final int experience = parseToInt(fields[12]);

    final User userValue = hasUser
        ? fields[10] as User
        : _buildUserFromLegacy(fields);

    // Old layouts stored "aboutus" at field 4; current layout at field 1.
    final String aboutus = hasUser
        ? (fields[1] ?? '').toString()
        : (fields[4] ?? '').toString();

    return Doctor(
      id: id,
      aboutus: aboutus,
      specialtyId: specialtyId,
      hospitalId: hospitalId,
      isFeatured: isFeatured,
      isTopDoctor: isTopDoctor,
      services: services,
      specialty: specialtyValue,
      hospital: hospitalValue,
      isFavorite: isFavorite,
      user: userValue,
      price: price,
      experience: experience,
    );
  }

  @override
  void write(BinaryWriter writer, Doctor obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.aboutus)
      ..writeByte(2)
      ..write(obj.specialtyId)
      ..writeByte(3)
      ..write(obj.hospitalId)
      ..writeByte(4)
      ..write(obj.isFeatured)
      ..writeByte(5)
      ..write(obj.isTopDoctor)
      ..writeByte(6)
      ..write(obj.services)
      ..writeByte(7)
      ..write(obj.specialty)
      ..writeByte(8)
      ..write(obj.hospital)
      ..writeByte(9)
      ..write(obj.isFavorite)
      ..writeByte(10)
      ..write(obj.user)
      ..writeByte(11)
      ..write(obj.price)
      ..writeByte(12)
      ..write(obj.experience);
  }

  static dynamic _pick(
    Map<int, dynamic> fields, {
    required int primary,
    required int legacy,
  }) {
    return fields.containsKey(primary) ? fields[primary] : fields[legacy];
  }

  static Specialty? _asSpecialty(dynamic value) {
    if (value is Specialty) return value;
    return null;
  }

  static Hospital? _asHospital(dynamic value) {
    if (value is Hospital) return value;
    return null;
  }

  static Location _defaultLocation() =>
      Location(id: 0, lat: 0.0, lng: 0.0, name: '');

  static User _buildUserFromLegacy(Map<int, dynamic> fields) {
    final name = (fields[1] ?? '').toString();
    final email = (fields[2] ?? '').toString();
    final phone = fields[3]?.toString();
    final gender = fields[8]?.toString();
    final profileImage = fields[11]?.toString();
    final birthDate = fields[12]?.toString();

    final locationValue = (fields[14] is Location)
        ? fields[14] as Location
        : _defaultLocation();
    final locationId = parseToInt(fields[5], fallback: locationValue.id);

    return User(
      id: parseToInt(fields[0]),
      name: name,
      email: email,
      token: '',
      phone: phone,
      address: null,
      profileImage: profileImage,
      birthDate: birthDate,
      gender: gender,
      location: locationValue,
      locationId: locationId,
    );
  }

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
