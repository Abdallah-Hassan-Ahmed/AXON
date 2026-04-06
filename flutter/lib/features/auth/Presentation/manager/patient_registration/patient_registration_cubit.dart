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

  PatientRegistrationFormState _formState = PatientRegistrationFormState();

  PatientRegistrationCubit(this.registerPatientUseCase)
      : super(PatientRegistrationFormState());

  PatientRegistrationFormState get currentState => _formState;

  /// update medical profile
  void updateMedicalProfile({
    String? bloodType,
    double? height,
    double? weight,
  }) {

    _formState = _formState.copyWith(
      bloodType: bloodType,
      height: height,
      weight: weight,
    );

    emit(_formState);
  }

  /// add condition
  void addCondition(String condition) {

    final updatedList = List<String>.from(_formState.conditions)
      ..add(condition);

    _formState = _formState.copyWith(
      conditions: updatedList,
    );

    emit(_formState);
  }

  /// remove condition
  void removeCondition(String condition) {

    final updatedList = List<String>.from(_formState.conditions)
      ..remove(condition);

    _formState = _formState.copyWith(
      conditions: updatedList,
    );

    emit(_formState);
  }

  /// add allergy
  void addAllergy(String allergy) {

    final updatedList = List<String>.from(_formState.allergies)
      ..add(allergy);

    _formState = _formState.copyWith(
      allergies: updatedList,
    );

    emit(_formState);
  }

  /// remove allergy
  void removeAllergy(String allergy) {

    final updatedList = List<String>.from(_formState.allergies)
      ..remove(allergy);

    _formState = _formState.copyWith(
      allergies: updatedList,
    );

    emit(_formState);
  }

  /// add radiology
  void addRadiology(RadiologyTestEntity radiology) {

    final updatedList = List<RadiologyTestEntity>.from(
      _formState.radiologyTests,
    )..add(radiology);

    _formState = _formState.copyWith(
      radiologyTests: updatedList,
    );

    emit(_formState);
  }

  /// remove radiology
  void removeRadiology(String id) {

    final updatedList = _formState.radiologyTests
        .where((test) => test.id != id)
        .toList();

    _formState = _formState.copyWith(
      radiologyTests: updatedList,
    );

    emit(_formState);
  }

  /// add lab test
  void addLabTest(LabTestEntity lab) {

    final updatedList = List<LabTestEntity>.from(
      _formState.labTests,
    )..add(lab);

    _formState = _formState.copyWith(
      labTests: updatedList,
    );

    emit(_formState);
  }

  /// remove lab test
  void removeLabTest(String id) {

    final updatedList = _formState.labTests
        .where((test) => test.id != id)
        .toList();

    _formState = _formState.copyWith(
      labTests: updatedList,
    );

    emit(_formState);
  }

  /// finish registration
  Future<void> finishRegistration() async {

    final formState = _formState;

    emit(PatientRegistrationLoading());

    /// Radiology Images
    List<File> radiologyImages = formState.radiologyTests
        .where((e) => e.image != null)
        .map((e) => File(e.image!))
        .toList();

    /// Radiology Descriptions
    List<String> radiologyDescriptions =
        formState.radiologyTests
            .map((e) => e.description ?? '')
            .toList();

    /// Lab Images
    List<File> labImages = formState.labTests
        .where((e) => e.image != null)
        .map((e) => File(e.image!))
        .toList();

    /// Lab Descriptions
    List<String> labDescriptions =
        formState.labTests
            .map((e) => e.description ?? '')
            .toList();

    var either = await registerPatientUseCase.invoke(

      personalPhoto: pref.getString("personalPhoto") != null
          ? File(pref.getString("personalPhoto")!)
          : null,

      fullName: pref.getString("fullName") ?? '',
      email: pref.getString("email") ?? '',
      password: pref.getString("password") ?? '',
      phoneNumber: pref.getString("phone") ?? '',
      gender: pref.getString("gender") ?? '',

      bloodType: formState.bloodType ?? '',
      height: formState.height ?? 0,
      weight: formState.weight ?? 0,

      conditions: formState.conditions,
      allergies: formState.allergies,

      radiologyImages: radiologyImages,
      radiologyDescriptions: radiologyDescriptions,

      labImages: labImages,
      labDescriptions: labDescriptions,
    );

    either.fold(
      (failure) {
        emit(PatientRegistrationError(failure: failure));
      },
      (data) {
        emit(PatientRegistrationSuccess(
          registerPatientEntity: data,
        ));
      },
    );
  }
}