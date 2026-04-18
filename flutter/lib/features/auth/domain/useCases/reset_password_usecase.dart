import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:Axon/features/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUsecase {
  final AuthRepo authRepo;

  ResetPasswordUsecase(this.authRepo);

  Future<Either<Failure, ForgotPasswordEntity>> invoke({
    required String token,
    required String password,
    required String passwordConfirm,
  }) {
    return authRepo.resetPassword(
      token: token,
      password: password,
      passwordConfirm: passwordConfirm,
    );
  }
}
