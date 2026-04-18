import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/core/helpers/snackbar.dart';
import 'package:Axon/features/patient/medicine/domain/usecases/add_medicine_use_case.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/medicine%20cubit/medicine_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit(
    this.addMedicineUseCase,
  ) : super(InitialMedicineState());

  final AddMedicineUseCase addMedicineUseCase;

  final TextEditingController medicineNameController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  String selectedFrequency = "once daily";

  List<String> intakeTimes = [];

  DateTime? startDate;
  DateTime? endDate;

  void changeFrequency(String value) {
    print("Frequency Changed => $value");

    selectedFrequency = value;
    intakeTimes.clear();

    emit(MedicineFrequencyChangedState());
  }

  void setIntakeTimes(List<String> times) {
    print("Intake Times Updated => $times");

    intakeTimes = times;

    emit(MedicineIntakeTimeChangedState());
  }

  void setDuration({
    required DateTime start,
    required DateTime end,
  }) {
    print("Duration Updated");
    print("Start Date => $start");
    print("End Date => $end");

    startDate = start;
    endDate = end;

    emit(MedicineDurationChangedState());
  }

  Future<void> addMedicine(BuildContext context) async {
    print("========== ADD MEDICINE START ==========");

    /// حماية من null crash
    if (!(formKey.currentState?.validate() ?? false)) {
      print("Form Validation Failed ❌");
      return;
    }

    print("Medicine Name => ${medicineNameController.text.trim()}");
    print("Selected Frequency => $selectedFrequency");
    print("Intake Times => $intakeTimes");

    print("Start Date BEFORE => $startDate");
    print("End Date BEFORE => $endDate");

    /// لو المستخدم لم يختار تاريخ البداية
    /// نخليه تلقائي = تاريخ اليوم
    startDate ??= DateTime.now();

    print("Start Date AFTER Default => $startDate");

    /// لو تاريخ النهاية غير موجود
    if (endDate == null) {
      print("ERROR ❌ End Date is NULL");

      Snackbar.showError(
        context,
        message: "Please select end date",
      );

      emit(
        MedicineErrorState(
          failure: ServerFailure(),
        ),
      );

      return;
    }

    /// لو تاريخ النهاية قبل البداية
    if (endDate!.isBefore(startDate!)) {
      print("ERROR ❌ End Date is before Start Date");

      Snackbar.showError(
        context,
        message: "End date must be after start date",
      );

      emit(
        MedicineErrorState(
          failure: ServerFailure(),
        ),
      );

      return;
    }

    print("Validation Passed ✅");

    print("Start Date FINAL => ${startDate!.toIso8601String()}");
    print("End Date FINAL => ${endDate!.toIso8601String()}");

    emit(MedicineLoadingState());

    /// =============================
/// medicine_cubit.dart
/// =============================

final result = await addMedicineUseCase.call(
  medicineName: medicineNameController.text.trim(),
  frequency: selectedFrequency,

  /// التعديل هنا فقط 🔥
  intakeTime: intakeTimes.isNotEmpty
      ? intakeTimes.first
      : "08:00",

  startDate: startDate!.toIso8601String(),
  endDate: endDate!.toIso8601String(),
);

    print("API Request Sent 🚀");

    result.fold(
      (failure) {
        print("API FAILED ❌");
        print("Failure => $failure");

        Snackbar.showError(
          context,
          message: "Failed to add medicine",
        );

        emit(
          MedicineErrorState(
            failure: failure,
          ),
        );
      },
      (response) {
        print("API SUCCESS ✅");
        print("Medicine Added Successfully");

        Snackbar.showSuccess(
          context,
          message: "Medicine added successfully",
        );

        emit(
          MedicineSuccessState(),
        );
      },
    );

    print("========== ADD MEDICINE END ==========");
  }
}