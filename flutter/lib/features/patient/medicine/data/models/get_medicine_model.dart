import 'package:Axon/features/patient/medicine/domain/entities/get_medicine_entity.dart';

class GetMedicineModel extends GetMedicineEntity {
  const GetMedicineModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory GetMedicineModel.fromJson(Map<String, dynamic> json) {
    return GetMedicineModel(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: (json["data"] as List<dynamic>? ?? [])
          .map(
            (e) => MedicineDataModel.fromJson(e),
          )
          .toList(),
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

  factory MedicineDataModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return MedicineDataModel(
      patientId: json["patientId"] ?? "",
      medicineName: json["medicineName"] ?? "",
      frequency: json["frequency"] ?? "",
      intakeTime: List<String>.from(
        json["intakeTime"] ?? [],
      ),
      startDate: json["startDate"] ?? "",
      endDate: json["endDate"] ?? "",
      isActive: json["isActive"] ?? false,
      id: json["_id"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }
}