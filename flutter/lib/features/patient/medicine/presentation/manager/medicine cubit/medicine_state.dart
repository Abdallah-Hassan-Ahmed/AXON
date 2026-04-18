import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/patient/medicine/domain/entities/medicine_entity.dart';

abstract class MedicineState {}

class InitialMedicineState extends MedicineState {}

class MedicineLoadingState extends MedicineState {}

class MedicineSuccessState extends MedicineState {
  final MedicineEntity? medicineEntity;

  MedicineSuccessState({
    this.medicineEntity,
  });
}

class MedicineErrorState extends MedicineState {
  final Failure failure;

  MedicineErrorState({
    required this.failure,
  });
}

class MedicineFrequencyChangedState extends MedicineState {}

class MedicineIntakeTimeChangedState extends MedicineState {}

class MedicineDurationChangedState extends MedicineState {}