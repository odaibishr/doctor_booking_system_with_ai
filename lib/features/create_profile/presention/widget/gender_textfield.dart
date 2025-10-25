import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class GenderTextField extends StatefulWidget {
  final ValueChanged<String?> onchanged;
  const GenderTextField({super.key, required this.onchanged});

  @override
  State<GenderTextField> createState() => _GenderTextFieldState();
}

class _GenderTextFieldState extends State<GenderTextField> {
  String? selectedGender;
  final List<String> genderItems = ['ذكر', 'أنثى'];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.male_outlined, color: AppColors.primary),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'الجنس',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      ),
      isExpanded: true,
      hint: const Text('اختر الجنس', style: TextStyle(fontSize: 14)),
      items: genderItems
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            ),
          )
          .toList(),
      value: selectedGender,
      onChanged: widget.onchanged,//TODO this the onChanged Function
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: AppColors.primary),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: AppColors.primary),
        ),
      ),
    );
  }
}
