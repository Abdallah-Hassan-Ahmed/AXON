import 'package:Axon/core/extensions/localization_ext.dart';
import 'package:Axon/core/style/colors.dart';
import 'package:Axon/core/widgets/text_app.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/time_cubit/intake-time_cubit.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/time_cubit/intake_time_state.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/update_medicine/update_medicine_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateIntakeTime extends StatefulWidget {
  final String initialTime;

  const UpdateIntakeTime({
    super.key,
    required this.initialTime,
  });

  @override
  State<UpdateIntakeTime> createState() =>
      _UpdateIntakeTimeState();
}

class _UpdateIntakeTimeState
    extends State<UpdateIntakeTime> {
  @override
  void initState() {
    super.initState();

    final intakeCubit =
        context.read<IntakeTimeCubit>();

    final updateCubit =
        context.read<UpdateMedicineCubit>();

    /// تحميل القيمة القديمة من الكارد 🔥
    final time = widget.initialTime.trim();

    if (time.isNotEmpty && time.contains(":")) {
      try {
        final parts = time.split(" ");

        final timePart = parts[0];
        final period =
            parts.length > 1 ? parts[1] : "AM";

        final split = timePart.split(":");

        int hour = int.parse(split[0]);
        int minute = int.parse(split[1]);

        final isAm =
            period.toUpperCase() == "AM";

        intakeCubit.setPickedTime(
          hour: hour,
          minute: minute,
          isAm: isAm,
        );

        updateCubit.selectedIntakeTime =
            widget.initialTime;
      } catch (e) {
        print("Time Parse Error => $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
        IntakeTimeCubit,
        IntakeTimeState>(
      builder: (context, state) {
        final intakeCubit =
            context.read<IntakeTimeCubit>();

        final updateCubit =
            context.read<UpdateMedicineCubit>();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _pickTime(
                  context,
                  intakeCubit,
                  updateCubit,
                  state,
                ),
                child: Column(
                  children: [
                    TextApp(
                      text: context.l10n.hour,
                      color:
                          AppColors.primaryColor,
                      weight:
                          AppTextWeight.bold,
                      fontSize: 12,
                    ),
                    const SizedBox(height: 8),
                    _box(
                      state.hour
                          .toString()
                          .padLeft(2, '0'),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding:
                    EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  ":",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => _pickTime(
                  context,
                  intakeCubit,
                  updateCubit,
                  state,
                ),
                child: Column(
                  children: [
                    TextApp(
                      text:
                          context.l10n.minute,
                      color:
                          AppColors.primaryColor,
                      weight:
                          AppTextWeight.bold,
                      fontSize: 12,
                    ),
                    const SizedBox(height: 8),
                    _box(
                      state.minute
                          .toString()
                          .padLeft(2, '0'),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 18),

              Column(
                children: [
                  GestureDetector(
                    onTap: intakeCubit.setAm,
                    child: _amPmBox(
                      context.l10n.am,
                      state.isAm,
                    ),
                  ),

                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: intakeCubit.setPm,
                    child: _amPmBox(
                      context.l10n.pm,
                      !state.isAm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickTime(
    BuildContext context,
    IntakeTimeCubit intakeCubit,
    UpdateMedicineCubit updateCubit,
    IntakeTimeState state,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: state.isAm
            ? state.hour % 12
            : (state.hour % 12) + 12,
        minute: state.minute,
      ),
    );

    if (picked != null) {
      final isAm = picked.hour < 12;

      final hour12 =
          picked.hour % 12 == 0
              ? 12
              : picked.hour % 12;

      intakeCubit.setPickedTime(
        hour: hour12,
        minute: picked.minute,
        isAm: isAm,
      );

      final period = isAm ? "AM" : "PM";

      final formattedTime =
          "${hour12.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')} $period";

      updateCubit.selectedIntakeTime =
          formattedTime;
    }
  }

  Widget _box(String value) {
    return Container(
      width: 70.w,
      height: 80.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius:
            BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          )
        ],
      ),
      child: TextApp(
        text: value,
        fontSize: 17,
        weight: AppTextWeight.bold,
      ),
    );
  }

  Widget _amPmBox(
    String text,
    bool selected,
  ) {
    return Container(
      width: 50.w,
      height: 36.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primaryColor
            : Colors.grey.shade300,
        borderRadius:
            BorderRadius.circular(12.r),
      ),
      child: TextApp(
        text: text,
        color: selected
            ? AppColors.white
            : AppColors.grey,
        weight: AppTextWeight.bold,
        fontSize: 14,
      ),
    );
  }
}