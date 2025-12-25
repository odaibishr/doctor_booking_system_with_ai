// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorScheduleAdapter extends TypeAdapter<DoctorSchedule> {
  @override
  final int typeId = 11;

  @override
  DoctorSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorSchedule(
      id: fields[0] as int,
      doctorId: fields[1] as int,
      dayId: fields[2] as int,
      startTime: fields[3] as String,
      endTime: fields[4] as String,
      day: fields[5] as Day?,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorSchedule obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorId)
      ..writeByte(2)
      ..write(obj.dayId)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.endTime)
      ..writeByte(5)
      ..write(obj.day);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
