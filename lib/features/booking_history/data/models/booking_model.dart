import 'dart:convert';

import 'package:doctor_booking_system_with_ai/core/layers/data/models/doctor_model.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/models/booking_transaction_model.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/models/doctor_schedule_model.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking_transaction.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/doctor_schedule.dart';

class BookingModel extends Booking {
  BookingModel({
    required super.id,
    required super.doctorId,
    required super.userId,
    required super.doctorScheduleId,
    required super.transactionId,
    required super.date,
    required super.status,
    required super.isCompleted,
    required super.paymentMode,
    required super.createdAt,
    required super.updatedAt,
    required super.doctor,
    required super.schedule,
    required super.transaction,
  });

  factory BookingModel.fromMap(Map<String, dynamic> data) => BookingModel(
        id: data['id'] ?? 0,
        doctorId: data['doctor_id'] ?? 0,
        userId: data['user_id'] ?? 0,
        doctorScheduleId: data['doctor_schedule_id'] ?? 0,
        transactionId: data['transaction_id'] ?? 0,
        date: data['date'] ?? '',
        status: data['status'] ?? '',
        isCompleted: _parseBool(data['is_completed']),
        paymentMode: data['payment_mode'] ?? '',
        createdAt: data['created_at'] ?? '',
        updatedAt: data['updated_at'] ?? '',
        doctor: DoctorModel.fromMap(_ensureMap(data['doctor'])),
        schedule: DoctorScheduleModel.fromMap(_ensureMap(data['schedule'])),
        transaction: BookingTransactionModel.fromMap(
          _ensureMap(data['transaction']),
        ),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'doctor_id': doctorId,
        'user_id': userId,
        'doctor_schedule_id': doctorScheduleId,
        'transaction_id': transactionId,
        'date': date,
        'status': status,
        'is_completed': isCompleted,
        'payment_mode': paymentMode,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'doctor': doctor,
        'schedule': schedule,
        'transaction': transaction,
      };

  factory BookingModel.fromJson(String data) {
    return BookingModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  BookingModel copyWith({
    int? id,
    int? doctorId,
    int? userId,
    int? doctorScheduleId,
    int? transactionId,
    String? date,
    String? status,
    bool? isCompleted,
    String? paymentMode,
    String? createdAt,
    String? updatedAt,
    DoctorModel? doctor,
    DoctorSchedule? schedule,
    BookingTransaction? transaction,
  }) {
    return BookingModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      userId: userId ?? this.userId,
      doctorScheduleId: doctorScheduleId ?? this.doctorScheduleId,
      transactionId: transactionId ?? this.transactionId,
      date: date ?? this.date,
      status: status ?? this.status,
      isCompleted: isCompleted ?? this.isCompleted,
      paymentMode: paymentMode ?? this.paymentMode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      doctor: doctor ?? this.doctor,
      schedule: schedule ?? this.schedule,
      transaction: transaction ?? this.transaction,
    );
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final lower = value.toLowerCase();
      return lower == 'true' || lower == '1';
    }
    return false;
  }

  static Map<String, dynamic> _ensureMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map(
        (key, val) => MapEntry(key.toString(), val),
      );
    }
    if (value is List && value.isNotEmpty && value.first is Map) {
      final first = value.first as Map;
      return first.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }
}
