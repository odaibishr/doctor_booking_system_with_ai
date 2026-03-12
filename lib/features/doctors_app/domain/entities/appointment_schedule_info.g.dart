// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedule_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentScheduleInfoAdapter
    extends TypeAdapter<AppointmentScheduleInfo> {
  @override
  final int typeId = 18;

  @override
  AppointmentScheduleInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentScheduleInfo(
      id: fields[0] as int,
      startTime: fields[1] as String,
      endTime: fields[2] as String,
      dayName: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentScheduleInfo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.dayName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentScheduleInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
