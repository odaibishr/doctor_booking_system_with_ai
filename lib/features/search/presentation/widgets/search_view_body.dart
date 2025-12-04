import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/manager/search_doctors_bloc/search_doctors_bloc.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/search_doctor_list_view.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/search_section.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<SearchDoctorsBloc>().add(SearchDoctorsQueryChanged(''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              CustomAppBar(
                userImage: 'assets/images/my-photo.jpg',
                title: 'كل الأطباء',
                isBackButtonVisible: false,
                isUserImageVisible: false,
              ),
              const SizedBox(height: 16),
              const SearchSection(),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
                  builder: (context, state) {
                    if (state is SearchDoctorsLoading) {
                      return const CustomLoader(loaderSize: kLoaderSize);
                    } else if (state is SearchDoctorsError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: FontStyles.body1.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                      );
                    } else if (state is SearchDoctorsLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تم العثور على ${state.doctors.length} طبيب',
                            style: FontStyles.body2.copyWith(
                              color: AppColors.gray400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: SearchDoctorListView(doctors: state.doctors),
                          ),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
