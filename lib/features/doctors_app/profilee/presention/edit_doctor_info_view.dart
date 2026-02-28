import 'dart:io';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/hospital_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/specialty_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_input_field.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presentation/widget/gender_textfield.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presentation/widget/profile_image.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_profile_state.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDoctorInfoView extends StatefulWidget {
  final Doctor doctor;
  const EditDoctorInfoView({super.key, required this.doctor});

  @override
  State<EditDoctorInfoView> createState() => _EditDoctorInfoViewState();
}

class _EditDoctorInfoViewState extends State<EditDoctorInfoView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _aboutController;
  late final TextEditingController _priceController;
  late final TextEditingController _experienceController;
  late final TextEditingController _newDurationController;
  late final TextEditingController _returnDurationController;
  late final TextEditingController _serviceInputController;

  String? _selectedGender;
  File? _selectedImage;
  late List<String> _services;
  int? _selectedSpecialtyId;
  int? _selectedHospitalId;
  List<Specialty> _specialties = [];
  List<Hospital> _hospitals = [];

  @override
  void initState() {
    super.initState();
    final d = widget.doctor;
    _nameController = TextEditingController(text: d.name);
    _phoneController = TextEditingController(text: d.phone);
    _aboutController = TextEditingController(text: d.aboutus);
    _priceController = TextEditingController(text: d.price.toStringAsFixed(0));
    _experienceController = TextEditingController(
      text: d.experience.toString(),
    );
    _newDurationController = TextEditingController(
      text: d.newPatientDuration.toString(),
    );
    _returnDurationController = TextEditingController(
      text: d.returningPatientDuration.toString(),
    );
    _serviceInputController = TextEditingController();
    _selectedGender = d.gender;
    _services = List<String>.from(d.services);
    _selectedSpecialtyId = d.specialtyId;
    _selectedHospitalId = d.hospitalId;
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    final specialtyDS = serviceLocator<SpecialtyLocalDataSource>();
    final hospitalDS = serviceLocator<HospitalLocalDataSource>();
    final specs = await specialtyDS.getSpecialties();
    final hosps = await hospitalDS.getCachedHospitals();
    if (mounted) {
      setState(() {
        _specialties = specs;
        _hospitals = hosps;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _aboutController.dispose();
    _priceController.dispose();
    _experienceController.dispose();
    _newDurationController.dispose();
    _returnDurationController.dispose();
    _serviceInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<DoctorProfileCubit>(),
      child: Scaffold(
        body: BlocConsumer<DoctorProfileCubit, DoctorProfileState>(
          listener: (context, state) {
            if (state is DoctorProfileLoaded) {
              context.showSuccessToast('تم تحديث البيانات بنجاح');
              Navigator.pop(context);
            }
            if (state is DoctorProfileError) {
              context.showErrorToast(state.message);
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const CustomAppBar(
                    title: 'تعديل المعلومات',
                    isBackButtonVisible: true,
                    isUserImageVisible: false,
                  ),
                  pinned: true,
                  backgroundColor: context.scaffoldBackgroundColor,
                  surfaceTintColor: context.scaffoldBackgroundColor,
                  automaticallyImplyLeading: false,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: state is DoctorProfileUpdating
                        ? const Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: Center(
                              child: CustomLoader(loaderSize: kLoaderSize),
                            ),
                          )
                        : _buildForm(context),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: ProfileImage(
              onImageSelected: (image) => _selectedImage = image,
              imageUrl: widget.doctor.profileImage,
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle('البيانات الأساسية'),
          const SizedBox(height: 12),
          MainInputField(
            hintText: 'الاسم الكامل',
            leftIconPath: 'assets/icons/user.svg',
            rightIconPath: 'assets/icons/user.svg',
            isShowRightIcon: true,
            isShowLeftIcon: false,
            controller: _nameController,
          ),
          const SizedBox(height: 12),
          MainInputField(
            hintText: 'رقم الهاتف',
            leftIconPath: 'assets/icons/call.svg',
            rightIconPath: 'assets/icons/call.svg',
            isShowRightIcon: true,
            isShowLeftIcon: false,
            isNumber: true,
            controller: _phoneController,
          ),
          const SizedBox(height: 12),
          GenderTextField(
            initialValue: _selectedGender,
            onchanged: (value) {
              _selectedGender = value == 'ذكر' ? 'Male' : 'Female';
            },
          ),
          const SizedBox(height: 12),
          _buildSelectorField(
            context,
            label: 'التخصص',
            value: _specialties
                .where((s) => s.id == _selectedSpecialtyId)
                .firstOrNull
                ?.name,
            icon: Icons.medical_services_outlined,
            onTap: () => _showSelectorSheet<Specialty>(
              context,
              title: 'اختر التخصص',
              items: _specialties,
              selectedId: _selectedSpecialtyId,
              getName: (s) => s.name,
              getId: (s) => s.id,
              onSelected: (id) => setState(() => _selectedSpecialtyId = id),
            ),
          ),
          const SizedBox(height: 12),
          _buildSelectorField(
            context,
            label: 'المستشفى',
            value: _hospitals
                .where((h) => h.id == _selectedHospitalId)
                .firstOrNull
                ?.name,
            icon: Icons.local_hospital_outlined,
            onTap: () => _showSelectorSheet<Hospital>(
              context,
              title: 'اختر المستشفى',
              items: _hospitals,
              selectedId: _selectedHospitalId,
              getName: (h) => h.name,
              getId: (h) => h.id,
              onSelected: (id) => setState(() => _selectedHospitalId = id),
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle('النبذة التعريفية'),
          const SizedBox(height: 12),
          TextFormField(
            controller: _aboutController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'اكتب نبذة عن نفسك...',
              hintStyle: FontStyles.body2.copyWith(color: context.gray400Color),
              filled: true,
              fillColor: AppColors.getGray100(context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle('معلومات المهنة'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: MainInputField(
                  hintText: 'سعر الكشف',
                  leftIconPath: 'assets/icons/dollar-circle.svg',
                  rightIconPath: 'assets/icons/dollar-circle.svg',
                  isShowRightIcon: true,
                  isShowLeftIcon: false,
                  isNumber: true,
                  controller: _priceController,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MainInputField(
                  hintText: 'سنوات الخبرة',
                  leftIconPath: 'assets/icons/folder.svg',
                  rightIconPath: 'assets/icons/folder.svg',
                  isShowRightIcon: true,
                  isShowLeftIcon: false,
                  isNumber: true,
                  controller: _experienceController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: MainInputField(
                  hintText: 'مدة كشف جديد (دقيقة)',
                  leftIconPath: 'assets/icons/timer.svg',
                  rightIconPath: 'assets/icons/timer.svg',
                  isShowRightIcon: true,
                  isShowLeftIcon: false,
                  isNumber: true,
                  controller: _newDurationController,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MainInputField(
                  hintText: 'مدة مراجعة (دقيقة)',
                  leftIconPath: 'assets/icons/timer.svg',
                  rightIconPath: 'assets/icons/timer.svg',
                  isShowRightIcon: true,
                  isShowLeftIcon: false,
                  isNumber: true,
                  controller: _returnDurationController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _sectionTitle('الخدمات'),
          const SizedBox(height: 12),
          _buildServicesChips(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: MainInputField(
                  hintText: 'أضف خدمة جديدة...',
                  leftIconPath: 'assets/icons/edit-2.svg',
                  rightIconPath: 'assets/icons/edit-2.svg',
                  isShowRightIcon: false,
                  isShowLeftIcon: false,
                  controller: _serviceInputController,
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _addService,
                icon: const Icon(Icons.add, color: Colors.white),
                style: IconButton.styleFrom(backgroundColor: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 32),
          MainButton(text: 'حفظ التعديلات', onTap: () => _submit(context)),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: FontStyles.subTitle1.copyWith(
        fontWeight: FontWeight.w600,
        color: context.primaryColor,
      ),
    );
  }

  Widget _buildSelectorField(
    BuildContext context, {
    required String label,
    required String? value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.getGray100(context),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: context.primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: FontStyles.body3.copyWith(
                      color: context.gray400Color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value ?? 'اختر...',
                    style: FontStyles.subTitle3.copyWith(
                      color: value != null
                          ? context.blackColor
                          : context.gray400Color,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 22,
              color: context.gray400Color,
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectorSheet<T>(
    BuildContext context, {
    required String title,
    required List<T> items,
    required int? selectedId,
    required String Function(T) getName,
    required int Function(T) getId,
    required ValueChanged<int> onSelected,
  }) {
    String searchQuery = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            final filtered = searchQuery.isEmpty
                ? items
                : items.where((i) => getName(i).contains(searchQuery)).toList();

            return DraggableScrollableSheet(
              initialChildSize: 0.55,
              maxChildSize: 0.85,
              minChildSize: 0.3,
              expand: false,
              builder: (_, scrollController) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: context.gray400Color,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        style: FontStyles.subTitle1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: (v) => setSheetState(() => searchQuery = v),
                        decoration: InputDecoration(
                          hintText: 'بحث...',
                          hintStyle: FontStyles.body2.copyWith(
                            color: context.gray400Color,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: context.gray400Color,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: AppColors.getGray100(context),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 1,
                            color: context.gray400Color.withValues(alpha: 0.2),
                          ),
                          itemBuilder: (_, index) {
                            final item = filtered[index];
                            final id = getId(item);
                            final isSelected = id == selectedId;

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              title: Text(
                                getName(item),
                                style: FontStyles.subTitle3.copyWith(
                                  color: isSelected
                                      ? AppColors.primary
                                      : context.blackColor,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                              trailing: isSelected
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: AppColors.primary,
                                      size: 22,
                                    )
                                  : null,
                              onTap: () {
                                onSelected(id);
                                Navigator.pop(sheetContext);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildServicesChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _services.map((s) {
        return Chip(
          label: Text(s, style: FontStyles.body3),
          deleteIcon: const Icon(Icons.close, size: 16),
          onDeleted: () => setState(() => _services.remove(s)),
          backgroundColor: AppColors.getGray100(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }).toList(),
    );
  }

  void _addService() {
    final text = _serviceInputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _services.add(text);
      _serviceInputController.clear();
    });
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<DoctorProfileCubit>();

    if (_selectedImage != null) {
      cubit.updateImage(_selectedImage!);
    }

    final genderToSend = _selectedGender?.toLowerCase() == 'female'
        ? 'Female'
        : 'Male';

    cubit.updateProfile({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'gender': genderToSend,
      'aboutus': _aboutController.text,
      'price': double.tryParse(_priceController.text) ?? 0,
      'experience': _experienceController.text,
      'specialty_id': _selectedSpecialtyId,
      'hospital_id': _selectedHospitalId,
      'new_patient_duration': int.tryParse(_newDurationController.text) ?? 30,
      'returning_patient_duration':
          int.tryParse(_returnDurationController.text) ?? 15,
      'services': _services,
    });
  }
}
