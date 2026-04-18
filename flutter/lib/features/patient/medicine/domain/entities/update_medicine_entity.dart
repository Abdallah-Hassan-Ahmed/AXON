
class UpdateMedicineEntity {
  final String status;
  final String message;
  final UpdateMedicineDataEntity data;

  const UpdateMedicineEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

class UpdateMedicineDataEntity {
  final String id;
  final String patientId;
  final String medicineName;
  final String frequency;
  final List<String> intakeTime;
  final String startDate;
  final String endDate;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  const UpdateMedicineDataEntity({
    required this.id,
    required this.patientId,
    required this.medicineName,
    required this.frequency,
    required this.intakeTime,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
}