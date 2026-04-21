import 'package:Axon/core/extensions/localization_ext.dart';
import 'package:Axon/core/style/colors.dart';
import 'package:Axon/core/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MedicineCard extends StatelessWidget {
  final String id;
  final String name;
  final String frequency;
  final String nextTime;
  final String startDate;
  final String endDate;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MedicineCard({
    super.key,
    required this.id,
    required this.name,
    required this.frequency,
    required this.nextTime,
    required this.startDate,
    required this.endDate,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final formattedStartDate =
        DateFormat("dd MMM yyyy").format(
      DateTime.parse(startDate),
    );

    final formattedEndDate =
        DateFormat("dd MMM yyyy").format(
      DateTime.parse(endDate),
    );

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 8.h,
      ),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color:
              AppColors.primaryColor.withOpacity(.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 18,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          /// الاسم + edit + delete في نفس المستوى 🔥
          Row(
            children: [
              Expanded(
                child: TextApp(
                  text: name,
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  weight: AppTextWeight.bold,
                ),
              ),

              IconButton(
                onPressed: onEdit,
                icon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                  size: 22.sp,
                ),
              ),

              IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 22.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          /// Frequency
          Align(
            alignment: Alignment.centerLeft,
            child: TextApp(
              text: frequency,
              color: AppColors.grey,
              fontSize: 13,
              weight: AppTextWeight.semiBold,
            ),
          ),

          SizedBox(height: 14.h),

          /// Next Time
          _infoRow(
            icon: Icons.timelapse_outlined,
            title: "${context.l10n.next}",
            value: nextTime,
          ),

          SizedBox(height: 10.h),

          /// Start Date
          _infoRow(
            icon: Icons.calendar_today_outlined,
            title: "Start",
            value: formattedStartDate,
          ),

          SizedBox(height: 10.h),

          /// End Date
          _infoRow(
            icon: Icons.event_available_outlined,
            title: "End",
            value: formattedEndDate,
          ),

          SizedBox(height: 20.h),

          /// ACTION BUTTONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.check,
                    size: 14.sp,
                    color: Colors.white,
                  ),
                  label: TextApp(
                    text: context.l10n.taken,
                    color: Colors.white,
                    fontSize: 14,
                    weight:
                        AppTextWeight.semiBold,
                  ),
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.primaryColor,
                    elevation: 0,
                    padding:
                        EdgeInsets.symmetric(
                      vertical: 14.h,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12.r,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.xmark,
                    size: 14.sp,
                    color: Colors.red,
                  ),
                  label: TextApp(
                    text: context.l10n.skip,
                    fontSize: 14,
                    weight:
                        AppTextWeight.semiBold,
                  ),
                  style:
                      OutlinedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(
                      vertical: 14.h,
                    ),
                    side: const BorderSide(
                      color: Colors.red,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12.r,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.grey,
        ),

        SizedBox(width: 6.w),

        TextApp(
          text: "$title:",
          fontSize: 12,
          color: AppColors.grey,
          weight: AppTextWeight.semiBold,
        ),

        SizedBox(width: 6.w),

        Expanded(
          child: TextApp(
            text: value,
            fontSize: 12,
            color: AppColors.black,
            weight: AppTextWeight.semiBold,
          ),
        ),
      ],
    );
  }
}