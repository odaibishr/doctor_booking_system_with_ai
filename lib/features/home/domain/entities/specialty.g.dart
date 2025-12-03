// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialty.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpecialtyAdapter extends TypeAdapter<Specialty> {
  @override
  final int typeId = 5;

  @override
  Specialty read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Specialty(
      id: fields[0] as int,
      name: fields[1] as String,
      icon: fields[2] as String,
      isActive: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Specialty obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecialtyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
