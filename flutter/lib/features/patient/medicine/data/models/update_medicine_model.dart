
import 'package:Axon/features/patient/medicine/domain/entities/update_medicine_entity.dart';

class UpdateMedicineModel extends UpdateMedicineEntity {
  const UpdateMedicineModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory UpdateMedicineModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UpdateMedicineModel(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: UpdateMedicineDataModel.fromJson(
        json["data"] ?? {},
      ),
    );
  }
}

class UpdateMedicineDataModel
    extends UpdateMedicineDataEntity {
  const UpdateMedicineDataModel({
    required super.id,
    required super.patientId,
    required super.medicineName,
    required super.frequency,
    required super.intakeTime,
    required super.startDate,
    required super.endDate,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UpdateMedicineDataModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UpdateMedicineDataModel(
      id: json["_id"] ?? "",
      patientId: json["patientId"] ?? "",
      medicineName: json["medicineName"] ?? "",
      frequency: json["frequency"] ?? "",
      intakeTime: List<String>.from(
        json["intakeTime"] ?? [],
      ),
      startDate: json["startDate"] ?? "",
      endDate: json["endDate"] ?? "",
      isActive: json["isActive"] ?? false,
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }
}