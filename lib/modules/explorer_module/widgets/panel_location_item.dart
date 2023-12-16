import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/modules/explorer_module/models/enum_inspection_status.dart';

class PanelLocationItem extends StatelessWidget {
  final double width;
  final Function() onPressed;
  final bool selected;
  final String roomName;
  const PanelLocationItem(
      {super.key,
      required this.width,
      required this.roomName,
      required this.onPressed,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? AppColors.lightBlue : AppColors.greyCC,
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: InspectionStatus.completed.getColor(),
              size: 20,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                roomName,
                style: AppTextStyles.display16w500,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
