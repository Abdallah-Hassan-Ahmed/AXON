import 'package:Axon/core/style/colors.dart';
import 'package:Axon/core/widgets/custom_dropdown_field.dart';
import 'package:Axon/features/patient/medicine/presentation/manager/update_medicine/update_medicine_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateFrequencyMedicineMenu extends StatelessWidget {
  final String initialValue;

  const UpdateFrequencyMedicineMenu({
    super.key,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateMedicineCubit>();

    final TextEditingController controller =
        TextEditingController(
      text: _normalizeFrequency(initialValue),
    );

    return CustomDropdownField(
      controller: controller,

      hintText: "Frequency",

      /// لازم نفس قيم API بالضبط
      items: const [
        "once daily",
        "twice daily",
        "three times daily",
      ],

      onChanged: (value) {
        if (value != null) {
          controller.text = value;
          cubit.selectedFrequency = value;
        }
      },

      prefixIcon: Icon(
        Icons.schedule,
        size: 18,
        color: AppColors.primaryColor.withOpacity(0.7),
      ),
    );
  }

  String _normalizeFrequency(String value) {
    final lower = value.toLowerCase().trim();

    if (lower.contains("once")) {
      return "once daily";
    }

    if (lower.contains("twice")) {
      return "twice daily";
    }

    if (lower.contains("three")) {
      return "three times daily";
    }

    return "once daily";
  }
}