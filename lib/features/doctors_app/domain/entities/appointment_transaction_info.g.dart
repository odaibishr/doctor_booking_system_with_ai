// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_transaction_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentTransactionInfoAdapter
    extends TypeAdapter<AppointmentTransactionInfo> {
  @override
  final int typeId = 17;

  @override
  AppointmentTransactionInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentTransactionInfo(
      id: fields[0] as int,
      amount: fields[1] as double,
      status: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentTransactionInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentTransactionInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
