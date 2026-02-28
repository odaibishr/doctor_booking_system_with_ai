abstract class DoctorDashboardRemoteDataSource {
  Future<Map<String, dynamic>> getDashboardStats({
    String filter = 'all',
  });
}