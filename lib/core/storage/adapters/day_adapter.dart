import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/day.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DayAdapter extends TypeAdapter<Day> {
  @override
  final int typeId = 10;

  @override
  Day read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Day(
      id: fields[0] as int,
      dayName: fields[1] as String,
      shortName: fields[2] as String,
      dayNumber: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Day obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dayName)
      ..writeByte(2)
      ..write(obj.shortName)
      ..writeByte(3)
      ..write(obj.dayNumber);
  }
}
