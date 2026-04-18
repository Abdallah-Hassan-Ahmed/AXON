import 'package:Axon/features/auth/domain/entities/forgot_password_entity.dart';

class ForgotPasswordDm extends ForgotPasswordEntity {
  ForgotPasswordDm({super.statusCode, super.status, super.message});

  factory ForgotPasswordDm.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordDm(
      statusCode: json['statusCode'],
      status: json['status'],
      message: json['message'],
    );
  }
}
