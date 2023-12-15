import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/circular_initials_widget.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/inspection_status.dart';

class ExplorerHeader extends StatelessWidget {
  final List<String> inspectors;
  final Widget leadingWidget;
  final bool showNoteEditIcon;
  final Function() onEdit;
  final String? projectId;
  final String? floorPlanId;
  final String? location;

  const ExplorerHeader({
    super.key,
    required this.inspectors,
    required this.leadingWidget,
    required this.showNoteEditIcon,
    required this.onEdit,
    this.projectId,
    this.floorPlanId,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.lightGrey2)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          leadingWidget,
          const Spacer(),
          const InspectionStatusLegend(),
          for (String name in inspectors)
            Padding(
              padding: const EdgeInsets.all(6),
              child: CircularInitialsWidget(
                bgColor: AppColors.lightGreen,
                text: name.characters.take(2).toString().toUpperCase(),
                textColor: AppColors.green00B779,
                size: 32,
              ),
            ),
          if (showNoteEditIcon) ...[
            const SizedBox(
              width: 24,
            ),
            Material(
              color: Colors.white,
              child: SizedBox(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: onEdit,
                  child: Center(
                      // child: EditNoteIcon(
                      //   projectId: projectId,
                      //   floorPlanId: floorPlanId,
                      //   location: location,
                      // ),
                      ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
