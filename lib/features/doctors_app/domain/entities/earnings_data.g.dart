// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earnings_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EarningsDataAdapter extends TypeAdapter<EarningsData> {
  @override
  final int typeId = 14;

  @override
  EarningsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EarningsData(
      today: fields[0] as double,
      week: fields[1] as double,
      month: fields[2] as double,
      all: fields[3] as double,
      filtered: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, EarningsData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.today)
      ..writeByte(1)
      ..write(obj.week)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.all)
      ..writeByte(4)
      ..write(obj.filtered);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EarningsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
