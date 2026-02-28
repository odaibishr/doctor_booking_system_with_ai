import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/models/appointment_schedule_info_model.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/models/appointment_transaction_info_model.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/data/models/patient_info_model.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';

class DoctorAppointmentModel extends DoctorAppointment {
  DoctorAppointmentModel({
    required super.id,
    required super.doctorId,
    required super.userId,
    required super.doctorScheduleId,
    required super.date,
    required super.status,
    required super.isCompleted,
    required super.createdAt,
    required super.updatedAt,
    super.cancellationReason,
    super.patientInfo,
    super.transactionInfo,
    super.scheduleInfo,
  });

  factory DoctorAppointmentModel.fromMap(Map<String, dynamic> map) {
    return DoctorAppointmentModel(
      id: parseToInt(map['id']),
      doctorId: parseToInt(map['doctor_id']),
      userId: parseToInt(map['user_id']),
      doctorScheduleId: parseToInt(map['doctor_schedule_id']),
      date: (map['date'] ?? '').toString(),
      status: (map['status'] ?? 'pending').toString(),
      isCompleted: map['is_completed'] == 1 || map['is_completed'] == true,
      cancellationReason: map['cancellation_reason']?.toString(),
      createdAt: (map['created_at'] ?? '').toString(),
      updatedAt: (map['updated_at'] ?? '').toString(),
      patientInfo: map['user'] is Map
          ? PatientInfoModel.fromMap(ensureMap(map['user']))
          : null,
      scheduleInfo: map['schedule'] is Map
          ? AppointmentScheduleInfoModel.fromMap(ensureMap(map['schedule']))
          : null,
      transactionInfo: map['transaction'] is Map
          ? AppointmentTransactionInfoModel.fromMap(
              ensureMap(map['transaction']),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'user_id': userId,
      'doctor_schedule_id': doctorScheduleId,
      'date': date,
      'status': status,
      'is_completed': isCompleted,
      'cancellation_reason': cancellationReason,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': (patientInfo as PatientInfoModel?)?.toMap(),
      'schedule': (scheduleInfo as AppointmentScheduleInfoModel?)?.toMap(),
      'transaction': (transactionInfo as AppointmentTransactionInfoModel?)
          ?.toMap(),
    };
  }
}
