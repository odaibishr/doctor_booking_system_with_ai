class PatientInfo {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;
  final String? gender;

  PatientInfo({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
    this.gender,
  });
}
