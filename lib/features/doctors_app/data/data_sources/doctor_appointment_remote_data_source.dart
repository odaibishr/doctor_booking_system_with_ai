import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/models/doctor_appointment_model.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';

abstract class DoctorAppointmentRemoteDataSource {
  Future<List<DoctorAppointment>> getAppointments({
    String? status,
    String? date,
  });

  Future<List<DoctorAppointment>> getTodayAppointments();
  Future<List<DoctorAppointment>> getUpcomingAppointments();
  Future<List<DoctorAppointment>> getHistoryAppointments();
  Future<DoctorAppointment> getAppointmentDetails(int id);
  Future<DoctorAppointment> updateAppointmentStatus({
    required int id,
    required String status,
    String? cancellationReason,
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

  @override
  Future<List<DoctorAppointment>> getTodayAppointments() async {
    final response = await dioConsumer.get('doctor/my-appointments/today');
    return parseList<DoctorAppointment>(
      response['data'],
      DoctorAppointmentModel.fromMap,
    );
  }

  @override
  Future<DoctorAppointment> getAppointmentDetails(int id) async {
    final response = await dioConsumer.get('doctor/my-appointments/$id');
    return DoctorAppointmentModel.fromMap(
      response['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<List<DoctorAppointment>> getHistoryAppointments() async {
    final response = await dioConsumer.get('doctor/my-appointments/history');
    return parseList<DoctorAppointment>(
      response['data'],
      DoctorAppointmentModel.fromMap,
    );
  }

  @override
  Future<List<DoctorAppointment>> getUpcomingAppointments() async {
    final response = await dioConsumer.get('doctor/my-appointments/upcoming');
    return parseList<DoctorAppointment>(
      response['data'],
      DoctorAppointmentModel.fromMap,
    );
  }

  @override
  Future<DoctorAppointment> updateAppointmentStatus({
    required int id,
    required String status,
    String? cancellationReason,
  }) async {
    final response = await dioConsumer.put(
      'doctor/my-appointments/$id/status',
      data: {
        'status': status,
        if (cancellationReason != null)
          'cancellation_reason': cancellationReason,
      },
    );
    return DoctorAppointmentModel.fromMap(
      response['data'] as Map<String, dynamic>,
    );
  }
}
