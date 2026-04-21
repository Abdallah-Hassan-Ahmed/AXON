
import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/patient/medicine/domain/entities/update_medicine_entity.dart';
import 'package:Axon/features/patient/medicine/domain/repo/medicine_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateMedicineUseCase {
  final MedicineRepo medicineRepo;

  UpdateMedicineUseCase(this.medicineRepo);

  Future<Either<Failure, UpdateMedicineEntity>> call({
    required String medicineId,
    required String medicineName,
    required String frequency,
    required String intakeTime,
    required String startDate,
    required String endDate,
  }) {
    return medicineRepo.updateMedicine(
      medicineId: medicineId,
      medicineName: medicineName,
      frequency: frequency,
      intakeTime: intakeTime,
      startDate: startDate,
      endDate: endDate,
    );
  }
}