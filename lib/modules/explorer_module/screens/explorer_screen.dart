import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/core/presentation/atoms/round_rectangale_chip.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/viewer_bloc.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/viewer_states.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/app_bar/app_bar_how_to_use.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/bim_viewer/bim_viewer_webview.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/bim_viewer/bim_viewer_widget.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/check_items_measurements_view.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/explorer_header.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/locations_panel.dart';
import 'package:minisitewalkapp/modules/unit_plans/models/unit_plan.dart';

class ExplorerScreen extends StatefulWidget {
  final UnitPlan unitItem;
  ExplorerScreen({required this.unitItem});

  @override
  State<ExplorerScreen> createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ViewerBloc>(
          create: (context) => ViewerBloc(),
        )
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // persistentFooterButtons: [
        //   ElevatedButton(onPressed: () {}, child: Text("ddasdadas"))
        // ],
        appBar: AppBarHowToUse(
          leadingPressed: () {
            Navigator.of(context).pop();
          },
          leadingWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //when location selected, add the location room to the leading description
              RichText(
                  text: TextSpan(
                      text: widget.unitItem.projectName,
                      children: [TextSpan(text: " / kitchen")],
                      style: AppTextStyles.display18w700)),
              SizedBox(
                width: 8,
              ),
              //chip status!
              RoundRectangleChip(text: "completed")
            ],
          ),
        ),
        body: Column(children: [
          //Another app header
          ExplorerHeader(
            inspectors: ["tailorbird"],
            leadingWidget: Text('Select Room to Edit floor plan Inspection',
                style: AppTextStyles.display14w400
                    .copyWith(color: AppColors.black)),
            showNoteEditIcon: false,
            onEdit: () {},
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  BimViewerWidget(),
                  Positioned(child: LocationsPanel()),
                  VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: AppColors.dividerColor,
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width * 0.3,
                  //     child: CheckItemsAndMeasurementsView(
                  //       onFinishClicked: () {},
                  //     ),
                  //   ),
                  // )
                ],
              ))
            ],
          ))
        ]),
      ),
    );
  }
}
