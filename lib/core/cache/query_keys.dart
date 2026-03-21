class QueryKeys {
  static const String doctors = 'doctors';
  static const String specialties = 'specialties';
  static const String allSpecialties = 'all_specialties';
  static const String hospitals = 'hospitals';
  static const String bookingHistory = 'booking_history';
  static const String favoriteDoctors = 'favorite_doctors';
  static const String profile = 'profile';

  static String doctorDetails(int id) => 'doctor_details_$id';
  static String doctorReviews(int id) => 'doctor_reviews_$id';
  static String hospitalDetails(int id) => 'hospital_details_$id';

  // doctor app keyes
  static const String doctorAppointments = 'doctor_appointments';
  static const String doctorTodayApporintments = 'doctor_today_appointments';
  static const String doctorUpcomingAppointments =
      'doctor_upcoming_appointments';
  static const String doctorHistoryAppointments = 'doctor_history_appointments';
  static const String doctorDashboard = 'doctor_dashboard';
  static String doctorAppointmentsByStatus(String status) =>
      'doctor_appointments_$status';
}
