// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HospitalAdapter extends TypeAdapter<Hospital> {
  @override
  final int typeId = 3;

  @override
  Hospital read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hospital(
      id: fields[0] as int,
      name: fields[1] as String,
      phone: fields[2] as String,
      email: fields[3] as String,
      website: fields[4] as String,
      address: fields[5] as String,
      image: fields[6] as String,
      locationId: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Hospital obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.website)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.locationId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HospitalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
