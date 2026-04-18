import 'package:Axon/core/extensions/localization_ext.dart';
import 'package:Axon/core/style/colors.dart';
import 'package:Axon/core/widgets/text_app.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/get_medicine.dart/medicine_list_cubit.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/get_medicine.dart/medicine_list_state.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/medicine_filter/medicine_filter_cubit.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/medicine_filter/medicine_filter_state.dart';
import 'package:Axon/features/patient/medicine/presentation/widget/medicine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineList extends StatelessWidget {
  const MedicineList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineListCubit, MedicineListState>(
      builder: (context, medicineState) {
        /// Loading
        if (medicineState is MedicineListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        /// Error
        if (medicineState is MedicineListError) {
          return Center(
            child: TextApp(
              text: "Failed to load medicines",
              color: AppColors.grey,
            ),
          );
        }

        /// Success
        if (medicineState is MedicineListSuccess) {
          return BlocBuilder<
              MedicineFilterCubit,
              MedicineFilterState>(
            builder: (context, filterState) {
              final selectedDate =
                  filterState.date ?? DateTime.now();

              final filtered =
                  medicineState.medicines.where((medicine) {
                final medicineDate =
                    DateTime.parse(medicine.startDate);

                final sameDay =
                    medicineDate.day ==
                            selectedDate.day &&
                        medicineDate.month ==
                            selectedDate.month &&
                        medicineDate.year ==
                            selectedDate.year;

                final matchSearch = medicine
                    .medicineName
                    .toLowerCase()
                    .contains(
                      filterState.search.toLowerCase(),
                    );

                return sameDay && matchSearch;
              }).toList();

              if (filtered.isEmpty) {
                return Center(
                  child: TextApp(
                    text:
                        context.l10n.no_medicine_today,
                    color: AppColors.grey,
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.only(top: 8.h),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final item = filtered[index];

                  /// الوقت من الـ API
                  final nextTime =
                      item.intakeTime.isNotEmpty
                          ? item.intakeTime.first
                          : "08:00";

                  /// عدد المرات من الـ API
                  final frequency = item.frequency;

                  return MedicineCard(
                    name: item.medicineName,

                    /// بدل once daily الثابت
                    frequency: frequency,

                    /// بدل 09:00 PM الثابت
                    nextTime: nextTime,
                  );
                },
                separatorBuilder: (_, __) =>
                    SizedBox(height: 12.h),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}