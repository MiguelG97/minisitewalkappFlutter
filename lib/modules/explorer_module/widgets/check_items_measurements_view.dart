import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/categroy_card.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/complete_inspection_button.dart';

/*
TODO:
* Check focusing a field on clicking BIM element is causing jank
* comeup with benchmark metrics - frame rate etc.,
* check how it is working with 10 or 20 categories
*/

class CheckItemsAndMeasurementsView extends StatefulWidget {
  final Function() onFinishClicked;
  const CheckItemsAndMeasurementsView(
      {super.key, required this.onFinishClicked});

  @override
  State<CheckItemsAndMeasurementsView> createState() =>
      _CheckItemsAndMeasurementsViewState();
}

class _CheckItemsAndMeasurementsViewState
    extends State<CheckItemsAndMeasurementsView> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CompleteInspectionButton(
            onPressed: widget.onFinishClicked,
            bgColor: AppColors.green00B779,
            text: 'Mark As Complete',
          ),
        ),
      ],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            child: Row(
              children: [
                Text(
                  'Check Measurement & Items',
                  style: AppTextStyles.display14w700
                      .copyWith(color: AppColors.black),
                ),
                //Commenting as this might be added again soon
                // HSpace.h8(),
                // const Icon(
                //   Icons.info,
                //   size: 14,
                //   color: AppColors.grey5C5F62,
                // )
              ],
            ),
          ),
          Divider(
            color: AppColors.dividerColor,
            thickness: 1,
            height: 1,
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  key: Key('today'),
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      headerText: "Floors",
                    );
                  },
                  itemCount: 5,
                )),
          ),
        ],
      ),
    );
  }
}
