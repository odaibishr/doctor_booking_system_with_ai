import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/data_sources/doctor_appointment_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';

class DoctorAppointmentRepoImpl implements DoctorAppointmentRepo {
  final DoctorAppointmentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DoctorAppointmentRepoImpl(this.remoteDataSource, this.networkInfo);
}
