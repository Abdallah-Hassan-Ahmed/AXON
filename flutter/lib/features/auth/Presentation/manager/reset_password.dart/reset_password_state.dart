

import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/auth/domain/entities/forgot_password_entity.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final ForgotPasswordEntity response;

  ResetPasswordSuccess({required this.response});
}

class ResetPasswordError extends ResetPasswordState {
  final Failure failure;

  ResetPasswordError({required this.failure});
}