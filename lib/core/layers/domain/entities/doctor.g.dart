// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorAdapter extends TypeAdapter<Doctor> {
  @override
  final int typeId = 2;

  @override
  Doctor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Doctor(
      id: fields[0] as int,
      aboutus: fields[1] as String,
      specialtyId: fields[2] as int,
      hospitalId: fields[3] as int,
      isFeatured: fields[4] as int,
      isTopDoctor: fields[5] as int,
      services: fields[6] as String,
      specialty: fields[7] as Specialty,
      hospital: fields[8] as Hospital,
      isFavorite: fields[9] as int,
      user: fields[10] as User,
      price: fields[11] as double,
      experience: fields[12] as int,
      schedules: (fields[13] as List?)?.cast<DoctorSchedule>(),
      newPatientDuration: fields[14] as int,
      returningPatientDuration: fields[15] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Doctor obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.aboutus)
      ..writeByte(2)
      ..write(obj.specialtyId)
      ..writeByte(3)
      ..write(obj.hospitalId)
      ..writeByte(4)
      ..write(obj.isFeatured)
      ..writeByte(5)
      ..write(obj.isTopDoctor)
      ..writeByte(6)
      ..write(obj.services)
      ..writeByte(7)
      ..write(obj.specialty)
      ..writeByte(8)
      ..write(obj.hospital)
      ..writeByte(9)
      ..write(obj.isFavorite)
      ..writeByte(10)
      ..write(obj.user)
      ..writeByte(11)
      ..write(obj.price)
      ..writeByte(12)
      ..write(obj.experience)
      ..writeByte(13)
      ..write(obj.schedules)
      ..writeByte(14)
      ..write(obj.newPatientDuration)
      ..writeByte(15)
      ..write(obj.returningPatientDuration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
