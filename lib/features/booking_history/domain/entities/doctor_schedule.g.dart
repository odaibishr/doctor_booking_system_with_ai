// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingHistoryScheduleAdapter
    extends TypeAdapter<BookingHistorySchedule> {
  @override
  final int typeId = 12;

  @override
  BookingHistorySchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingHistorySchedule(
      id: fields[0] as int,
      doctorId: fields[1] as int,
      dayId: fields[2] as int,
      startTime: fields[3] as String,
      endTime: fields[4] as String,
      createdAt: fields[5] as String,
      updatedAt: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookingHistorySchedule obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingHistoryScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
