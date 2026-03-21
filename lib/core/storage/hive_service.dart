import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/storage/adapters/safe_doctor_adapter.dart';
import 'package:doctor_booking_system_with_ai/core/storage/adapters/safe_user_adapter.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/appointment_schedule_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/appointment_transaction_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/earnings_data.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/patient_info.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/doctor_schedule.dart'
    as history_schedule;
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking_transaction.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart'
    show DoctorScheduleAdapter, DoctorSchedule;
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/day.dart'
    show DayAdapter;

class HiveService {
  static const String userBoxName = 'user_box';
  static Box<User>? _userBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    // check if adapters are registered
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SafeUserAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SafeDoctorAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(HospitalAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(LocationAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(SpecialtyAdapter());
    }
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(BookingAdapter());
    }
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(DayAdapter());
    }
    if (!Hive.isAdapterRegistered(11)) {
      Hive.registerAdapter(DoctorScheduleAdapter());
    }
    if (!Hive.isAdapterRegistered(12)) {
      Hive.registerAdapter(history_schedule.BookingHistoryScheduleAdapter());
    }
    if (!Hive.isAdapterRegistered(13)) {
      Hive.registerAdapter(BookingTransactionAdapter());
    }
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(ReviewAdapter());
    }
    if (!Hive.isAdapterRegistered(14)) {
      Hive.registerAdapter(EarningsDataAdapter());
    }
    if (!Hive.isAdapterRegistered(15)) {
      Hive.registerAdapter(DashboardStatsAdapter());
    }
    if (!Hive.isAdapterRegistered(16)) {
      Hive.registerAdapter(PatientInfoAdapter());
    }
    if (!Hive.isAdapterRegistered(17)) {
      Hive.registerAdapter(AppointmentTransactionInfoAdapter());
    }
    if (!Hive.isAdapterRegistered(18)) {
      Hive.registerAdapter(AppointmentScheduleInfoAdapter());
    }
    if (!Hive.isAdapterRegistered(19)) {
      Hive.registerAdapter(DoctorAppointmentAdapter());
    }
    if (!Hive.isAdapterRegistered(20)) {
      Hive.registerAdapter(DoctorDayOffAdapter());
    }

    _userBox = await Hive.openBox<User>(userBoxName);
    await Hive.openBox<Doctor>(kDoctorBox);
    await Hive.openBox<Specialty>(kSpecialtyBox);
    await Hive.openBox<Hospital>(kHospitalBox);
    await Hive.openBox<Booking>(kBookingHistoryBox);
    await Hive.openBox<Review>(kReviewBox);
    await Hive.openBox<DashboardStats>(kDashboardBox);
    await Hive.openBox<EarningsData>(kEarningsBox);
    await Hive.openBox<List<DoctorAppointment>>(kDoctorAppointmentBox);
    await Hive.openBox<Doctor>(kProfileBox);
    await Hive.openBox<List<DoctorSchedule>>(kDoctorMySchedulesBox);
    await Hive.openBox<List<DoctorDayOff>>(kDoctorDaysOffBox);
  }

  static Future<void> cacheAuthData(User user) async {
    await _userBox?.put('current_user', user);
  }

  static User? getCachedAuthData() {
    return _userBox?.get('current_user');
  }

  static Future<void> clearUser() async {
    await _userBox?.clear();
  }
}
