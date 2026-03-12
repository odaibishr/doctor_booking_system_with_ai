// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_appointment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorAppointmentAdapter extends TypeAdapter<DoctorAppointment> {
  @override
  final int typeId = 19;

  @override
  DoctorAppointment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorAppointment(
      id: fields[0] as int,
      doctorId: fields[1] as int,
      userId: fields[2] as int,
      doctorScheduleId: fields[3] as int,
      date: fields[4] as String,
      status: fields[5] as String,
      isCompleted: fields[6] as bool,
      cancellationReason: fields[7] as String?,
      createdAt: fields[8] as String,
      updatedAt: fields[9] as String,
      patientInfo: fields[10] as PatientInfo?,
      transactionInfo: fields[11] as AppointmentTransactionInfo?,
      scheduleInfo: fields[12] as AppointmentScheduleInfo?,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorAppointment obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.doctorScheduleId)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.isCompleted)
      ..writeByte(7)
      ..write(obj.cancellationReason)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.patientInfo)
      ..writeByte(11)
      ..write(obj.transactionInfo)
      ..writeByte(12)
      ..write(obj.scheduleInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorAppointmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
