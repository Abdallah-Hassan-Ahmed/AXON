
import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/patient/medicine/domain/entities/delete_medicine_entity.dart';
import 'package:Axon/features/patient/medicine/domain/repo/medicine_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteMedicineUseCase {
  final MedicineRepo medicineRepo;

  DeleteMedicineUseCase(this.medicineRepo);

  Future<Either<Failure, DeleteMedicineEntity>> call({
    required String medicineId,
  }) {
    return medicineRepo.deleteMedicine(
      medicineId: medicineId,
    );
  }
}