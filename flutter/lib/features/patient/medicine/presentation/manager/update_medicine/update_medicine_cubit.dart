import 'package:Axon/features/patient/medicine/domain/usecases/update_medicine_use_case.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/update_medicine/update_medicine_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateMedicineCubit extends Cubit<UpdateMedicineState> {
  final UpdateMedicineUseCase updateMedicineUseCase;

  /// Frequency
  String selectedFrequency = "once daily";

  /// Intake Time
  String selectedIntakeTime = "";

  /// Duration
  String selectedStartDate = "";
  String selectedEndDate = "";

  UpdateMedicineCubit({
    required this.updateMedicineUseCase,
  }) : super(UpdateMedicineInitial());

  /// ================================
  /// تحميل البيانات القديمة من الكارد
  /// ================================
  void setInitialValues({
    required String frequency,
    required String intakeTime,
    required String startDate,
    required String endDate,
  }) {
    selectedFrequency = frequency.toLowerCase();

    /// هنا أهم سطر 🔥
    selectedIntakeTime = intakeTime;

    selectedStartDate = startDate;
    selectedEndDate = endDate;

    emit(UpdateMedicineInitial());
  }

  /// ================================
  /// Update Medicine API
  /// ================================
  Future<void> updateMedicine({
    required String medicineId,
    required String medicineName,
    required String frequency,
    required String intakeTime,
    required String startDate,
    required String endDate,
  }) async {
    emit(UpdateMedicineLoading());

    final result = await updateMedicineUseCase.call(
      medicineId: medicineId,
      medicineName: medicineName,

      /// نرسل القيمة المختارة من الـ dropdown
      frequency: selectedFrequency,

      /// نرسل الـ intake الحقيقي
      intakeTime: selectedIntakeTime.isNotEmpty
          ? selectedIntakeTime
          : intakeTime,

      /// نرسل التواريخ المعدلة أو القديمة
      startDate: selectedStartDate.isNotEmpty
          ? selectedStartDate
          : startDate,

      endDate: selectedEndDate.isNotEmpty
          ? selectedEndDate
          : endDate,
    );

    result.fold(
      (failure) {
        emit(
          UpdateMedicineError(
            failure: failure,
          ),
        );
      },
      (_) {
        emit(UpdateMedicineSuccess());
      },
    );
  }
}