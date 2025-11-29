// ignore_for_file: public_member_api_docs, sort_constructors_first
class Profile {
  final String phone;
  final String birthDate;
  final String gender;
  final int locationId;
  final String? profileImage;

  Profile({
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.locationId,
    this.profileImage,
  });
}
