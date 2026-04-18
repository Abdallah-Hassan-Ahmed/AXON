import 'package:Axon/core/di/di.dart';
import 'package:Axon/core/extensions/localization_ext.dart';

import 'package:Axon/core/style/colors.dart';
import 'package:Axon/core/widgets/custom_button.dart';
import 'package:Axon/core/widgets/custom_text_field.dart';
import 'package:Axon/core/widgets/text_app.dart';
import 'package:Axon/features/auth/Presentation/manager/forgot%20password/forgot_password_cubit.dart';
import 'package:Axon/features/auth/Presentation/manager/reset_password.dart/reset_password_cubit.dart';
import 'package:Axon/features/auth/Presentation/manager/reset_password.dart/reset_password_state.dart';
import 'package:Axon/features/auth/Presentation/views/widgets/form_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {

    final forgotCubit = context.read<ForgotPasswordCubit>();
    final token = forgotCubit.otpToken;

    print("📌 TOKEN FROM CUBIT = $token");

    return BlocProvider(
      create: (_) => getIt<ResetPasswordCubit>(),

      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(

        builder: (context, state) {

          final cubit = context.read<ResetPasswordCubit>();

          return Scaffold(
            backgroundColor: AppColors.white,

            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),

              child: Form(
                key: cubit.formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 80.h),

                    TextApp(
                      text: context.l10n.create_new_password,
                      fontSize: 22,
                      weight: AppTextWeight.semiBold,
                    ),

                    SizedBox(height: 30.h),

                    FormLabel(text: context.l10n.new_password),

                    CustomTextField(
                      controller: cubit.passwordController,
                      hintText: context.l10n.enter_new_password,
                      isPassword: true,
                    ),

                    SizedBox(height: 22.h),

                    FormLabel(text: context.l10n.confirm_new_password),

                    CustomTextField(
                      controller: cubit.confirmPasswordController,
                      hintText: context.l10n.confirm_new_password,
                      isPassword: true,
                    ),

                    SizedBox(height: 35.h),

                    CustomButton(
                      text: context.l10n.reset_password,
                      height: 50.h,

                      onPressed: () {

                        print("📤 TOKEN SENT TO API = $token");

                        context.read<ResetPasswordCubit>()
                            .resetPassword(context, token);

                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },

        listener: (context, state) {},
      ),
    );
  }
}