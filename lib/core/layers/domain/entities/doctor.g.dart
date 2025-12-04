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
      name: fields[1] as String,
      email: fields[2] as String,
      phone: fields[3] as String,
      aboutus: fields[4] as String,
      locationId: fields[5] as int,
      specialtyId: fields[6] as int,
      hospitalId: fields[7] as int,
      gender: fields[8] as String,
      isFeatured: fields[9] as int,
      isTopDoctor: fields[10] as int,
      profileImage: fields[11] as String,
      birthday: fields[12] as String,
      services: fields[13] as String,
      location: fields[14] as Location,
      specialty: fields[15] as Specialty,
      hospital: fields[16] as Hospital,
    );
  }

  @override
  void write(BinaryWriter writer, Doctor obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.aboutus)
      ..writeByte(5)
      ..write(obj.locationId)
      ..writeByte(6)
      ..write(obj.specialtyId)
      ..writeByte(7)
      ..write(obj.hospitalId)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.isFeatured)
      ..writeByte(10)
      ..write(obj.isTopDoctor)
      ..writeByte(11)
      ..write(obj.profileImage)
      ..writeByte(12)
      ..write(obj.birthday)
      ..writeByte(13)
      ..write(obj.services)
      ..writeByte(14)
      ..write(obj.location)
      ..writeByte(15)
      ..write(obj.specialty)
      ..writeByte(16)
      ..write(obj.hospital);
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
