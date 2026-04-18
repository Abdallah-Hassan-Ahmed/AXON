/// =============================
/// medicine_entity.dart
/// =============================

class MedicineEntity {
  final String status;
  final String message;
  final MedicineDataEntity data;

  const MedicineEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

class MedicineDataEntity {
  final String patientId;
  final String medicineName;
  final String frequency;

  /// التعديل هنا 🔥
  final List<String> intakeTime;

  final String startDate;
  final String endDate;
  final bool isActive;
  final String id;
  final String createdAt;
  final String updatedAt;

  const MedicineDataEntity({
    required this.patientId,
    required this.medicineName,
    required this.frequency,

    /// التعديل هنا 🔥
    required this.intakeTime,

    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });
}