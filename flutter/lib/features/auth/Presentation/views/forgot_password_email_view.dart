import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Axon/core/di/di.dart';
import 'package:Axon/features/auth/Presentation/manager/forgot password/forgot_password_cubit.dart';
import 'package:Axon/features/auth/Presentation/manager/forgot password/forgot_password_state.dart';
import 'forgot_password_otp_view.dart';

class ForgotPasswordEmailView extends StatelessWidget {
  ForgotPasswordEmailView({super.key});

  final forgotCubit = getIt<ForgotPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => forgotCubit,
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) {
          final cubit = context.read<ForgotPasswordCubit>();

          return Scaffold(
            appBar: AppBar(title: const Text("Forgot Password")),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [

                    TextFormField(
                      controller: cubit.emailController,
                      decoration: const InputDecoration(
                        hintText: "Enter email",
                      ),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: () {
                        cubit.sendEmail(context);
                      },
                      child: const Text("Send Code"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<ForgotPasswordCubit>(),
                  child: const ForgotPasswordOtpView(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}