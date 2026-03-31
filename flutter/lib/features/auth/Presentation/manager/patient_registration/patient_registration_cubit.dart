import 'dart:io';

import 'package:Axon/core/service/shared_pref/shared_pref.dart';
import 'package:Axon/features/auth/domain/entities/medical_profile_entity.dart';
import 'package:Axon/features/auth/domain/useCases/register_patient_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'patient_registration_state.dart';
@injectable
class PatientRegistrationCubit extends Cubit<PatientRegistrationState> {
  final RegisterPatientUseCase registerPatientUseCase;
  final pref = SharedPref();

  PatientRegistrationCubit(this.registerPatientUseCase)
    : super(PatientRegistrationFormState());

  PatientRegistrationFormState get currentState =>
      state as PatientRegistrationFormState;

  /// update medical profile
  void updateMedicalProfile({
    String? bloodType,
    double? height,
    double? weight,
  }) {
    emit(
      currentState.copyWith(
        bloodType: bloodType,
        height: height,
        weight: weight,
      ),
    );
  }

  /// add condition
  void addCondition(String condition) {
    final updatedList = List<String>.from(currentState.conditions)
      ..add(condition);

    emit(currentState.copyWith(conditions: updatedList));
  }

  /// remove condition
  void removeCondition(String condition) {
    final updatedList = List<String>.from(currentState.conditions)
      ..remove(condition);

    emit(currentState.copyWith(conditions: updatedList));
  }

  /// add allergy
  void addAllergy(String allergy) {
    final updatedList = List<String>.from(currentState.allergies)..add(allergy);

    emit(currentState.copyWith(allergies: updatedList));
  }

  /// remove allergy
  void removeAllergy(String allergy) {
    final updatedList = List<String>.from(currentState.allergies)
      ..remove(allergy);

    emit(currentState.copyWith(allergies: updatedList));
  }

  /// add radiology
  void addRadiology(RadiologyTestEntity radiology) {
    final updatedList = List<RadiologyTestEntity>.from(
      currentState.radiologyTests,
    )..add(radiology);

    emit(currentState.copyWith(radiologyTests: updatedList));
  }

  /// remove radiology
  void removeRadiology(String id) {
    final updatedList = currentState.radiologyTests
        .where((test) => test.id != id)
        .toList();

    emit(currentState.copyWith(radiologyTests: updatedList));
  }

  /// add lab test
  void addLabTest(LabTestEntity lab) {
    final updatedList = List<LabTestEntity>.from(currentState.labTests)
      ..add(lab);

    emit(currentState.copyWith(labTests: updatedList));
  }

  /// remove lab test
  void removeLabTest(String id) {
    final updatedList = currentState.labTests
        .where((test) => test.id != id)
        .toList();

    emit(currentState.copyWith(labTests: updatedList));
  }

  ///finishRegistration

  Future<void> finishRegistration() async {

  emit(PatientRegistrationLoading());

  /// Radiology Images
  List<File> radiologyImages = currentState.radiologyTests
      .where((e) => e.image != null)
      .map((e) => File(e.image!))
      .toList();

  /// Radiology Descriptions
  List<String> radiologyDescriptions = currentState.radiologyTests
      .map((e) => e.description ?? '')
      .toList();

  /// Lab Images
  List<File> labImages = currentState.labTests
      .where((e) => e.image != null)
      .map((e) => File(e.image!))
      .toList();

  /// Lab Descriptions
  List<String> labDescriptions = currentState.labTests
      .map((e) => e.description ?? '')
      .toList();

  var either = await registerPatientUseCase.invoke(

    /// Personal Data
    personalPhoto: pref.getString("personalPhoto") != null
        ? File(pref.getString("personalPhoto")!)
        : null,

    fullName: pref.getString("fullName") ?? '',
    email: pref.getString("email") ?? '',
    password: pref.getString("password") ?? '',
    phoneNumber: pref.getString("phone") ?? '',
    gender: pref.getString("gender") ?? '',

    /// Medical Profile
    bloodType: currentState.bloodType ?? '',
    height: currentState.height ?? 0,
    weight: currentState.weight ?? 0,

    conditions: currentState.conditions,
    allergies: currentState.allergies,

    /// Radiology
    radiologyImages: radiologyImages,
    radiologyDescriptions: radiologyDescriptions,

    /// Lab
    labImages: labImages,
    labDescriptions: labDescriptions,
  );

  either.fold(
    (failure) {
      emit(PatientRegistrationError(failure: failure));
    },
    (data) {
      emit(PatientRegistrationSuccess(registerPatientEntity: data));
    },
  );
}

}
