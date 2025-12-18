// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    final locationValue = (fields[9] is Location)
        ? fields[9] as Location
        : Location(id: 0, lat: 0.0, lng: 0.0, name: '');
    final locationIdValue = (fields[10] is int)
        ? fields[10] as int
        : (fields[10] is num)
            ? (fields[10] as num).toInt()
            : locationValue.id;
    return User(
      phone: fields[4] as String?,
      address: fields[5] as String?,
      profileImage: fields[6] as String?,
      birthDate: fields[7] as String?,
      gender: fields[8] as String?,
      location: locationValue,
      id: fields[0] as int,
      name: fields[1] as String,
      email: fields[2] as String,
      token: fields[3] as String,
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

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
