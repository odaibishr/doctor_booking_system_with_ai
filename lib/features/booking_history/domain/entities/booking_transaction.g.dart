// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingTransactionAdapter extends TypeAdapter<BookingTransaction> {
  @override
  final int typeId = 13;

  @override
  BookingTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingTransaction(
      id: fields[0] as int,
      amount: fields[1] as int,
      paymentGatewayDetailId: fields[2] as int,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookingTransaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.paymentGatewayDetailId)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
