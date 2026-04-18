
import 'package:Axon/features/patient/medicine/domain/entities/delete_medicine_entity.dart';

class DeleteMedicineModel extends DeleteMedicineEntity {
  const DeleteMedicineModel({
    required super.status,
    required super.message,
  });

  factory DeleteMedicineModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DeleteMedicineModel(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
    );
  }
}