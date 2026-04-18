import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:Axon/features/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordUsecase {
  final AuthRepo authRepo;

  ForgotPasswordUsecase(this.authRepo);

  Future<Either<Failure, ForgotPasswordEntity>>  invoke({
    required String email,
  }) {
    return authRepo.forgotPassword(
      email: email,
     
    );
  }
}