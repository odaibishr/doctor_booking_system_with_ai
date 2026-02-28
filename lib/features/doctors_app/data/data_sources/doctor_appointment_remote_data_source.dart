import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/models/doctor_appointment_model.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';

abstract class DoctorAppointmentRemoteDataSource {
  Future<List<DoctorAppointment>> getAppointments({
    String? status,
    String? date,
  });
}

class DoctorAppointmentRemoteDataSourceImpl
    implements DoctorAppointmentRemoteDataSource {
  final DioConsumer dioConsumer;

  DoctorAppointmentRemoteDataSourceImpl(this.dioConsumer);

  @override
  Future<List<DoctorAppointment>> getAppointments({
    String? status,
    String? date,
  }) async {
    final response = await dioConsumer.get(
      'doctor/my-appointments',
      queryParameters: {
        if (status != null) 'status': status,
        if (date != null) 'date': date,
      },
    );

    return parseList<DoctorAppointment>(
      response['data'],
      DoctorAppointmentModel.fromMap,
    );
  }
}
