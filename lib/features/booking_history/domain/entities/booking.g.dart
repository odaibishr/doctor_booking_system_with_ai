// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingAdapter extends TypeAdapter<Booking> {
  @override
  final int typeId = 6;

  @override
  Booking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Booking(
      id: fields[0] as int,
      doctorId: fields[1] as int,
      userId: fields[2] as int,
      doctorScheduleId: fields[3] as int,
      transactionId: fields[4] as int,
      date: fields[5] as String,
      status: fields[6] as String,
      isCompleted: fields[7] as bool,
      paymentMode: fields[8] as String,
      createdAt: fields[9] as String,
      updatedAt: fields[10] as String,
      doctor: fields[11] as Doctor,
      schedule: fields[12] as BookingHistorySchedule,
      transaction: fields[13] as BookingTransaction,
      isReturning: fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Booking obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.doctorScheduleId)
      ..writeByte(4)
      ..write(obj.transactionId)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.isCompleted)
      ..writeByte(8)
      ..write(obj.paymentMode)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.doctor)
      ..writeByte(12)
      ..write(obj.schedule)
      ..writeByte(13)
      ..write(obj.transaction)
      ..writeByte(14)
      ..write(obj.isReturning);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
