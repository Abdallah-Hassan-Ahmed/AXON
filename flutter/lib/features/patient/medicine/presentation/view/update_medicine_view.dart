import 'package:Axon/core/di/di.dart';
import 'package:Axon/core/extensions/localization_ext.dart';
import 'package:Axon/core/style/colors.dart';
import 'package:Axon/core/widgets/custom_app_bar.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/duration_cubit/duration_cubit.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/time_cubit/intake-time_cubit.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/update_medicine/update_medicine_cubit.dart';
import 'package:Axon/features/patient/medicine/presentation/widget/update_medicine_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateMedicineView extends StatelessWidget {
  final String medicineId;
  final String medicineName;
  final String frequency;
  final String intakeTime;
  final String startDate;
  final String endDate;

  const UpdateMedicineView({
    super.key,
    required this.medicineId,
    required this.medicineName,
    required this.frequency,
    required this.intakeTime,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<UpdateMedicineCubit>(),
        ),
        BlocProvider(
          create: (_) => IntakeTimeCubit(),
        ),
        BlocProvider(
          create: (_) => DurationCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            CustomAppBar(
              title: context.l10n.edit_medicine,
            ),
            Expanded(
              child: UpdateMedicineBody(
                medicineId: medicineId,
                medicineName: medicineName,
                frequency: frequency,
                intakeTime: intakeTime,
                startDate: startDate,
                endDate: endDate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}