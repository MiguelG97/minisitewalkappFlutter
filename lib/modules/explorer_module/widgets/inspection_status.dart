import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/modules/explorer_module/models/enum_inspection_status.dart';

class InspectionStatusLegend extends StatelessWidget {
  const InspectionStatusLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (InspectionStatus status in InspectionStatus.values) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Material(
              color: status.getColor(),
              child: const SizedBox(
                width: 12,
                height: 12,
              ),
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            status.getDisplayText(),
            style: AppTextStyles.display14w400.copyWith(color: AppColors.black),
          ),
          SizedBox(
            width: 12,
          )
        ]
      ],
    );
  }
}
