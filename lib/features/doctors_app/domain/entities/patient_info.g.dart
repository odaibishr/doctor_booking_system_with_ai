// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientInfoAdapter extends TypeAdapter<PatientInfo> {
  @override
  final int typeId = 16;

  @override
  PatientInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatientInfo(
      id: fields[0] as int,
      name: fields[1] as String,
      email: fields[2] as String,
      phone: fields[3] as String?,
      profileImage: fields[4] as String?,
      gender: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PatientInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.profileImage)
      ..writeByte(5)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
