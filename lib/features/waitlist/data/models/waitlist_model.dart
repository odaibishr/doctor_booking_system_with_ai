import 'package:doctor_booking_system_with_ai/core/layers/data/models/doctor_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/domain/entities/waitlist_entry.dart';

class WaitlistModel extends WaitlistEntry {
  WaitlistModel({
    required super.id,
    required super.userId,
    required super.doctorId,
    super.preferredDate,
    super.preferredScheduleId,
    required super.status,
    super.notifiedAt,
    super.expiresAt,
    required super.position,
    required super.createdAt,
    required super.updatedAt,
    super.doctor,
  });

  factory WaitlistModel.fromJson(Map<String, dynamic> json) {
    Doctor? doctor;
    if (json['doctor'] != null && json['doctor'] is Map) {
      doctor = DoctorModel.fromMap(json['doctor'] as Map<String, dynamic>);
    }

    return WaitlistModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      doctorId: json['doctor_id'] as int,
      preferredDate: json['preferred_date'] as String?,
      preferredScheduleId: json['preferred_schedule_id'] as int?,
      status: json['status'] as String,
      notifiedAt: json['notified_at'] != null
          ? DateTime.parse(json['notified_at'] as String)
          : null,
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'] as String)
          : null,
      position: json['position'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      doctor: doctor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'doctor_id': doctorId,
      'preferred_date': preferredDate,
      'preferred_schedule_id': preferredScheduleId,
      'status': status,
      'notified_at': notifiedAt?.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
      'position': position,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
