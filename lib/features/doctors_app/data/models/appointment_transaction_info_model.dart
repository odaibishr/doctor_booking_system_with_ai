import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/appointment_transaction_info.dart';

class AppointmentTransactionInfoModel extends AppointmentTransactionInfo {
  AppointmentTransactionInfoModel({
    required super.id,
    required super.amount,
    required super.status,
  });

  factory AppointmentTransactionInfoModel.fromMap(Map<String, dynamic> map) {
    return AppointmentTransactionInfoModel(
      id: parseToInt(map['id']),
      amount: parseToDouble(map['amount']),
      status: (map['status'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'amount': amount, 'status': status};
  }
}
