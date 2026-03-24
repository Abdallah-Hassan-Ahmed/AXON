import 'package:Axon/core/extensions/localization_ext.dart';
import 'package:Axon/features/auth/Presentation/manager/doctor registration/doctor_registration_cubit.dart';
import 'package:Axon/features/auth/Presentation/manager/doctor%20registration/doctor_registration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UploadMedicalLicenseBox extends StatelessWidget {
  const UploadMedicalLicenseBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DoctorRegistrationCubit>().pickLicenseFile();
      },
      child: BlocBuilder<DoctorRegistrationCubit, DoctorRegistrationState>(
        builder: (context, state) {
          XFile? file;

          if (state is DoctorRegistrationInitial) {
            file = state.uploadedFile;
          }

          return Container(
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Center(
              child: file == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload_outlined),
                        SizedBox(height: 10),
                        Text(context.l10n.drag_upload),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(height: 10),
                        Text(file.name),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
