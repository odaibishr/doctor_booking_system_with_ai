import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/day.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
}
