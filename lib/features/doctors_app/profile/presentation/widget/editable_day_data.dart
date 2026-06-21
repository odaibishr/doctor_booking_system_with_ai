import 'package:flutter/material.dart';

class EditableDayData {
  final int dayId;
  final String dayName;
  bool isActive;
  final int? scheduleId;
  TimeOfDay startTime;
  TimeOfDay endTime;
  final int? dayOffId;
  final bool wasOriginallyDayOff;
  final bool hadSchedule;

  EditableDayData({
    required this.dayId,
    required this.dayName,
    required this.isActive,
    required this.scheduleId,
    required this.startTime,
    required this.endTime,
    required this.dayOffId,
    required this.wasOriginallyDayOff,
    required this.hadSchedule,
  });
}
