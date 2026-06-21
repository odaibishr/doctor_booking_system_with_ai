import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/features/payment/data/repos/payment_repo_impl.dart';
import 'package:doctor_booking_system_with_ai/features/payment/domain/repos/payment_repo.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/manager/payment_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/use_cases/create_appointment_use_case.dart';

class PaymentInjection {
  static void register(GetIt sl) {
    sl.registerLazySingleton<PaymentRepo>(() => PaymentRepoImpl());

    sl.registerFactory<PaymentCubit>(
      () => PaymentCubit(
        paymentRepo: sl(),
        createAppointmentUseCase: sl<CreateAppointmentUseCase>(),
      ),
    );
  }
}
