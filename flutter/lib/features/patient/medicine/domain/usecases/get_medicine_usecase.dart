import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/patient/medicine/domain/entities/get_medicine_entity.dart';
import 'package:Axon/features/patient/medicine/domain/repo/medicine_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMedicinesUseCase {
  final MedicineRepo medicineRepo;

  GetMedicinesUseCase(this.medicineRepo);

  Future<Either<Failure, GetMedicineEntity>> call() {
    return medicineRepo.getMedicines();
  }
}