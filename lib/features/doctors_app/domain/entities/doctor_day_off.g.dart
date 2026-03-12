// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_day_off.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorDayOffAdapter extends TypeAdapter<DoctorDayOff> {
  @override
  final int typeId = 20;

  @override
  DoctorDayOff read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorDayOff(
      id: fields[0] as int,
      doctorId: fields[1] as int,
      dayId: fields[2] as int,
      day: fields[3] as Day?,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorDayOff obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorId)
      ..writeByte(2)
      ..write(obj.dayId)
      ..writeByte(3)
      ..write(obj.day);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorDayOffAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
