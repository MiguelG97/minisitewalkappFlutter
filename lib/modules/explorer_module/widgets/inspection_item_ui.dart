import 'dart:math';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/core/presentation/atoms/custom_switch.dart';
import 'package:minisitewalkapp/core/presentation/atoms/custom_text_field.dart';

class InspectionItemUI extends StatelessWidget {
  const InspectionItemUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'floors',
                  style: AppTextStyles.display14w500,
                ),
              ),
            ),
            if (true)
              _YesORNoWrapper(
                initialValue: true,
                elementID: "12393",
                onClickWhenDisabled: () {},
                onSelectionChanged: (val) {},
              )
          ],
        ),
        // for (int index = 0;
        //     index < entriesWithoutCountField.length;
        //     index++) ...[
        //   _AttributeWidget(
        //     entity: entity,
        //     entry: entriesWithoutCountField[index],
        //     isFirstItem: !showRadio && index == 0,
        //   )
        // ],
        Divider(
          height: 32,
          color: AppColors.dividerColor,
        ),
      ],
    );
  }
}

class _AttributeWidget extends StatelessWidget {
  final MapEntry<String, dynamic> entry;
  final bool isFirstItem;
  const _AttributeWidget({
    required this.entry,
    required this.isFirstItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 8,
        ),
        if (entry.key != 'Value') ...[
          Text(
            entry.key,
            style: AppTextStyles.display14w500,
          ),
          SizedBox(
            height: 8,
          ),
        ],
        ItemDataField(
          entry: entry,
          isFirst: isFirstItem,
        )
      ],
    );
  }
}

class ItemDataField extends StatefulWidget {
  final MapEntry<String, dynamic> entry;
  final bool isFirst;
  const ItemDataField(
      {super.key,
      required this.entry,
      // required this.itemEntity,
      this.isFirst = false});

  @override
  State<ItemDataField> createState() => _ItemDataFieldState();
}

class _ItemDataFieldState extends State<ItemDataField> {
  late TextEditingController controller =
      TextEditingController(text: '${widget.entry.value}');

  final FocusNode focusNode = FocusNode();
  late MapEntry<String, dynamic> localCopyOfEntry = widget.entry;

  bool receivedBIMEvent = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CustomTextField(
        enabled: true,
        focusNode: focusNode,
        key: Key('${localCopyOfEntry.key}_datafield'),
        childKey: '${localCopyOfEntry.key}_datafield_child',
        controller: controller,
        hintText: 'Enter ${localCopyOfEntry.key}',
        inputType: TextInputType.text,
        fillColor: getColor(),
      ),
    );
  }

  Color getColor() {
    return AppColors.lightGrey;
  }
}

class _YesORNoWrapper extends StatefulWidget {
  final void Function() onClickWhenDisabled;
  final void Function(bool) onSelectionChanged;
  final bool initialValue;
  final String? elementID;
  const _YesORNoWrapper({
    required this.onClickWhenDisabled,
    required this.onSelectionChanged,
    required this.initialValue,
    required this.elementID,
  });

  @override
  State<_YesORNoWrapper> createState() => __YesORNoWrapperState();
}

class __YesORNoWrapperState extends State<_YesORNoWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightBlue, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: CustomSwitch(
        onClickWhenDisabled: widget.onClickWhenDisabled,
        disabled: false,
        onChanged: widget.onSelectionChanged,
        value: widget.initialValue,
      ),
    );
  }
}
