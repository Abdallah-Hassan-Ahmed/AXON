import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/auth/Presentation/manager/forgot password/forgot_password_state.dart';
import 'package:Axon/features/auth/domain/useCases/forgot_password_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {

  final ForgotPasswordUsecase forgotPasswordUsecase;

  ForgotPasswordCubit({required this.forgotPasswordUsecase})
      : super(ForgotPasswordInitial());

  final emailController = TextEditingController();
  final otpController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String otpToken = '';

  /// SEND EMAIL
  Future<void> sendEmail(BuildContext context) async {

    if (formKey.currentState!.validate()) {

      emit(ForgotPasswordLoading());

      final result = await forgotPasswordUsecase.invoke(
        email: emailController.text,
      );

      result.fold(
        (failure) => emit(ForgotPasswordError(failure: failure)),
        (response) => emit(ForgotPasswordSuccess(entity: response)),
      );
    }
  }

  /// VERIFY OTP
  void verifyOtp(BuildContext context) {

    if (otpController.text.isEmpty) {

      emit(
        ForgotPasswordError(
          failure: ServerFailure(),
        ),
      );

      return;
    }

    /// حفظ الكود داخل الكيوبت
    otpToken = otpController.text;

    print("📌 OTP SAVED IN CUBIT = $otpToken");

    emit(ForgotPasswordSuccess());
  }

  /// RESEND CODE
  Future<void> resendCode(BuildContext context) async {

    if (emailController.text.isEmpty) return;

    emit(ForgotPasswordLoading());

    final result = await forgotPasswordUsecase.invoke(
      email: emailController.text,
    );

    result.fold(
      (failure) => emit(ForgotPasswordError(failure: failure)),
      (response) => emit(ForgotPasswordSuccess(entity: response)),
    );
  }
}