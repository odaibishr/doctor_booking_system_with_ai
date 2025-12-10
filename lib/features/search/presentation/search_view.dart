import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/search_view_body.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.specialtyQuery});
  final String specialtyQuery;

  @override
  Widget build(BuildContext context) {
    return SearchViewBody(specialtyQuery: specialtyQuery);
  }
}
