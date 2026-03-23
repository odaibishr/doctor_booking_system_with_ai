import 'package:doctor_booking_system_with_ai/features/search/presentation/manager/search_doctors_cubit/search_doctors_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/search_view_body.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, this.specialtyQuery});
  final int? specialtyQuery;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<SearchDoctorsCubit>(),
      child: SearchViewBody(specialtyQuery: specialtyQuery),
    );
  }
}
