import 'package:flutter/material.dart';

int parseToInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse('${value ?? ''}') ?? fallback;
}

double parseToDouble(dynamic value, {double fallback = 0.0}) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse('${value ?? ''}') ?? fallback;
}

Map<String, dynamic> ensureMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return value.map((key, val) => MapEntry(key.toString(), val));
  }
  return <String, dynamic>{};
}

List<T> parseList<T>(
  dynamic value,
  T Function(Map<String, dynamic> map) mapper,
) {
  if (value is! List) return <T>[];
  return value.map((item) => mapper(ensureMap(item))).toList();
}

String dayNameById(int id) {
  const names = {
    1: 'السبت',
    2: 'الأحد',
    3: 'الاثنين',
    4: 'الثلاثاء',
    5: 'الأربعاء',
    6: 'الخميس',
    7: 'الجمعة',
  };
  return names[id] ?? 'يوم $id';
}

String to12hFull(TimeOfDay time) {
  int hour = time.hour;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = hour >= 12 ? 'PM' : 'AM';
  if (hour == 0) hour = 12;
  if (hour > 12) hour -= 12;
  return '${hour.toString().padLeft(2, '0')}:$minute $period';
}
