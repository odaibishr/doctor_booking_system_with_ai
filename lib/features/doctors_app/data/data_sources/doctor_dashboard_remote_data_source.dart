import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';

abstract class DoctorDashboardRemoteDataSource {
  Future<Map<String, dynamic>> getDashboardStats({String filter = 'all'});
}

class DoctorDashboardRemoteDataSourceImpl
    implements DoctorDashboardRemoteDataSource {
  final DioConsumer dioConsumer;

  DoctorDashboardRemoteDataSourceImpl(this.dioConsumer);

  @override
  Future<Map<String, dynamic>> getDashboardStats({
    String filter = 'all',
  }) async {
    final response = await dioConsumer.get(
      '/doctor/dashboard',
      queryParameters: {'filter': filter},
    );

    return response['data'] as Map<String, dynamic>;
  }
}
