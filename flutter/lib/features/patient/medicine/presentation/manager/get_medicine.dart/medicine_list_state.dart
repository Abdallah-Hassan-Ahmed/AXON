
import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/patient/medicine/domain/entities/get_medicine_entity.dart';

abstract class MedicineListState {}

class MedicineListInitial extends MedicineListState {}

class MedicineListLoading extends MedicineListState {}

class MedicineListSuccess extends MedicineListState {
  final List<MedicineDataEntity> medicines;

  MedicineListSuccess({
    required this.medicines,
  });
}

class MedicineListError extends MedicineListState {
  final Failure failure;

  MedicineListError({
    required this.failure,
  });
}