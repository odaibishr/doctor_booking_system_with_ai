import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 4;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      id: fields[0] as int,
      lat: fields[1] as double,
      lng: fields[2] as double,
      name: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lng)
      ..writeByte(3)
      ..write(obj.name);
  }
}
