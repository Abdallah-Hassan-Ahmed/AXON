
class DoctorEntity {
  final String id;
  final String fullName;
  final String? email;
  final String? phoneNumber;
  final String? personalPhoto;
  final String? gender;
  final String? specialization;
  final int? yearsExperience;
  final String? about;
  final int? price;

  DoctorEntity({
    required this.id,
    required this.fullName,
    this.email,
    this.phoneNumber,
    this.personalPhoto,
    this.gender,
    this.specialization,
    this.yearsExperience,
    this.about,
    this.price,
  });
}