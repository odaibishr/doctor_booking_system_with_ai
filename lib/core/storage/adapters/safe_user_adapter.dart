import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SafeUserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    final locationValue = _asLocation(fields[9]) ??
        Location(
          id: 0,
          lat: 0.0,
          lng: 0.0,
          name: '',
        );

    final locationIdValue = _toInt(fields[10], fallback: locationValue.id);

    final profileImage = _normalizeNullableString(fields[6]);

    return User(
      id: _toInt(fields[0]),
      name: (fields[1] ?? '').toString(),
      email: (fields[2] ?? '').toString(),
      token: (fields[3] ?? '').toString(),
      phone: fields[4]?.toString(),
      address: fields[5]?.toString(),
      profileImage: profileImage,
      birthDate: fields[7]?.toString(),
      gender: fields[8]?.toString(),
      location: locationValue,
      locationId: locationIdValue,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.profileImage)
      ..writeByte(7)
      ..write(obj.birthDate)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.location)
      ..writeByte(10)
      ..write(obj.locationId);
  }

  static int _toInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse('${value ?? ''}') ?? fallback;
  }

  static Location? _asLocation(dynamic value) {
    if (value is Location) return value;
    return null;
  }

  static String? _normalizeNullableString(dynamic value) {
    if (value == null) return null;
    final s = value.toString().trim();
    if (s.isEmpty) return null;
    if (s.toLowerCase() == 'null') return null;
    return s;
  }
}
