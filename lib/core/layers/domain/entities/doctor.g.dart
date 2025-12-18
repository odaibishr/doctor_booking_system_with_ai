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

    final specialtyValue = (fields[7] is Specialty)
        ? fields[7] as Specialty
        : Specialty(id: 0, name: '', icon: '', isActive: false);
    final hospitalValue = (fields[8] is Hospital)
        ? fields[8] as Hospital
        : Hospital(
            id: 0,
            name: '',
            phone: '',
            email: '',
            website: '',
            address: '',
            image: '',
            locationId: 0,
            doctors: null,
          );
    final userValue = (fields[10] is User)
        ? fields[10] as User
        : User(
            id: 0,
            name: '',
            email: '',
            token: '',
            phone: null,
            address: null,
            profileImage: null,
            birthDate: null,
            gender: null,
            location: Location(id: 0, lat: 0.0, lng: 0.0, name: ''),
            locationId: 0,
          );

    return Doctor(
      id: _toInt(fields[0]),
      aboutus: (fields[1] ?? '').toString(),
      specialtyId: _toInt(fields[2]),
      hospitalId: _toInt(fields[3]),
      isFeatured: _toInt(fields[4]),
      isTopDoctor: _toInt(fields[5]),
      services: (fields[6] ?? '').toString(),
      specialty: specialtyValue,
      hospital: hospitalValue,
      isFavorite: _toInt(fields[9]),
      user: userValue,
      price: _toDouble(fields[11]),
      experience: _toInt(fields[12]),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse('${value ?? ''}') ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse('${value ?? ''}') ?? 0.0;
  }

  @override
  void write(BinaryWriter writer, Doctor obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.experience);
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
