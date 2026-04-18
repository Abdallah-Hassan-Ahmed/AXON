import 'package:Axon/features/patient/medicine/domain/entities/medicine_entity.dart';

class MedicineModel extends MedicineEntity {
  const MedicineModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: MedicineDataModel.fromJson(json["data"] ?? {}),
    );
  }
}

class MedicineDataModel extends MedicineDataEntity {
  const MedicineDataModel({
    required super.patientId,
    required super.medicineName,
    required super.frequency,
    required super.intakeTime,
    required super.startDate,
    required super.endDate,
    required super.isActive,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MedicineDataModel.fromJson(Map<String, dynamic> json) {
    return MedicineDataModel(
      patientId: json["patientId"] ?? "",
      medicineName: json["medicineName"] ?? "",
      frequency: json["frequency"] ?? "",
      intakeTime: List<String>.from(json["intakeTime"] ?? []),
      startDate: json["startDate"] ?? "",
      endDate: json["endDate"] ?? "",
      isActive: json["isActive"] ?? false,
      id: json["_id"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }
}