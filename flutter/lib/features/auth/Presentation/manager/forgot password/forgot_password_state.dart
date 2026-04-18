

import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/auth/domain/entities/forgot_password_entity.dart';


abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordEntity? entity;

  ForgotPasswordSuccess({this.entity});
}

class ForgotPasswordError extends ForgotPasswordState {
  final Failure failure;

  ForgotPasswordError({required this.failure});
}