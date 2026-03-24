import 'package:Axon/core/di/di.dart';
import 'package:Axon/features/auth/Presentation/manager/selected%20gender/gender_cubit.dart';
import 'package:Axon/features/auth/domain/useCases/register_doctor_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'doctor_registration_state.dart';
import 'dart:io';

@injectable
class DoctorRegistrationCubit extends Cubit<DoctorRegistrationState> {
  final RegisterDoctorUseCase registerDoctorUseCase;
  DoctorRegistrationCubit({required this.registerDoctorUseCase})
    : super(DoctorRegistrationInitial());

  final experienceCtrl = TextEditingController();
  final licenseCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // 🔥 specialization variable
  String? selectedSpecialization;

  final picker = ImagePicker();

  XFile? licenseFile;

  // 🔥 change function
  void changeSpecialization(String value) {
    selectedSpecialization = value;
    emit(
      DoctorRegistrationInitial(selectedSpecialization: selectedSpecialization),
    );
  }

  // ================= FILE PICK =================

  Future<void> pickLicenseFile() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      licenseFile = picked;

      emit(
        DoctorRegistrationInitial(
          selectedSpecialization: selectedSpecialization,
          uploadedFile: licenseFile,
        ),
      );
    }
  }

  Future<void> doctorRegistration() async {
    if (formKey.currentState!.validate() == true) {
      final gender = getIt<GenderCubit>().genderValue;

      if (selectedSpecialization == null) {
        emit(DoctorRegistrationErrorMessage("Please select specialization"));
        return;
      }

      if (licenseFile == null) {
        emit(DoctorRegistrationErrorMessage("Upload license image"));
        return;
      }

      emit(DoctorRegistrationLoading());
      var either = await registerDoctorUseCase.invoke(
        fullName: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phoneNumber: phoneController.text,
        gender: gender,
        specialization: selectedSpecialization ?? "",
        yearsExperience: int.tryParse(experienceCtrl.text) ?? 0,
        medicalLicenseNumber: licenseCtrl.text,
        price: int.tryParse(priceCtrl.text) ?? 0,
        about: aboutCtrl.text,
        licenseImages: File(licenseFile!.path),
      );
      either.fold(
        (error) => emit(DoctorRegistrationError(failure: error)),
        (response) =>
            emit(DoctorRegistrationSuccess(registerDoctorEntity: response)),
      );
    }
  }
}
