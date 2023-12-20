// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/checkMeasurements_bloc.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/inspection_item_ui.dart';

class CategoryCard extends StatefulWidget {
  String headerText;
  List<dynamic> items;
  CategoryCard({required this.headerText, required this.items});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _isExpanded = false;
  List<Widget> children = [];

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void initState() {
    //ignoring items that has 0 viewables!!
    children = [
      Divider(
        color: AppColors.dividerColor,
        height: 1,
      ),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.items
              .where((item) => item["viewables"].length > 0)
              .map((item) => InspectionItemUI(
                    item: item,
                    categoryName: widget.headerText,
                  ))
              .toList(),
        ),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckMeasureBloc, CheckMeasureState>(
      listener: (context, state) {
        //expand the collapseable on selection!
        if (state is NewSelection) {
          bool result = widget.items.any((item) => item["dbId"] == state.dbId);

          setState(() {
            _isExpanded = result;
          });
        }
      },
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(0xFFCCCCCC),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _toggleExpanded,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.headerText,
                      style: AppTextStyles.display14w700
                          .copyWith(color: AppColors.black),
                    ),
                    const Spacer(),
                    Transform.rotate(
                      angle: _isExpanded ? pi : 0,
                      child: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.greyIcon,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isExpanded) ...children
          ],
        ),
      ),
    );
  }
}
