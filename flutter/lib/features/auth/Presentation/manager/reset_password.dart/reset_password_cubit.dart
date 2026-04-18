import 'package:Axon/features/auth/Presentation/manager/reset_password.dart/reset_password_state.dart';
import 'package:Axon/features/auth/domain/useCases/reset_password_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {

  final ResetPasswordUsecase resetPasswordUsecase;

  ResetPasswordCubit({required this.resetPasswordUsecase})
      : super(ResetPasswordInitial());

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> resetPassword(BuildContext context, String token) async {

    print("🚀 RESET PASSWORD FUNCTION STARTED");

    print("🔑 TOKEN = $token");
    print("🔐 PASSWORD = ${passwordController.text}");
    print("🔐 CONFIRM PASSWORD = ${confirmPasswordController.text}");

    if (formKey.currentState!.validate()) {

      emit(ResetPasswordLoading());

      print("📡 CALLING API...");

      var either = await resetPasswordUsecase.invoke(
        token: token,
        password: passwordController.text,
        passwordConfirm: confirmPasswordController.text,
      );

      either.fold(

        (error) {

          print("❌ API ERROR");

          emit(ResetPasswordError(failure: error));

        },

        (response) {

          print("✅ API SUCCESS");

          emit(ResetPasswordSuccess(response: response));

        },

      );

    } else {

      print("⚠️ FORM VALIDATION FAILED");

    }
  }
}