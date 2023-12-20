import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/core/presentation/atoms/custom_switch.dart';
import 'package:minisitewalkapp/core/presentation/atoms/custom_text_field.dart';

class InspectionItemUI extends StatelessWidget {
  dynamic item;
  List<String> booleanCat = [
    "Revit Specialty Equipment",
    "Revit Slab Edges",
    "Revit Generic Models",
    "Revit Plumbing Fixtures"
  ];
  List<String> numberCat = [
    "Revit Dimensions",
    "Revit Doors",
    "Revit Casework",
    "Revit Windows"
  ];
  String categoryName;
  List<String> textCat = ["Revit Floors"];
  InspectionItemUI({super.key, required this.item, required this.categoryName});
  Map<String, dynamic> attributes = {};

  @override
  Widget build(BuildContext context) {
    if (numberCat.any((element) => element.contains(categoryName))) {
      List<dynamic> props = item["props"] as List<dynamic>;
      switch (categoryName) {
        case "Dimensions":
          dynamic value =
              props.firstWhere((element) => element["displayName"] == "Value");
          attributes["Value"] = value["displayValue"];
          break;
        case "Doors":
          dynamic height =
              props.firstWhere((element) => element["displayName"] == "Height");
          attributes["Height"] = height["displayValue"];
          dynamic width =
              props.firstWhere((element) => element["displayName"] == "Width");
          attributes["Width"] = width["displayValue"];
          break;
        case "Casework":
          try {
            dynamic sheight = props.firstWhere(
                (element) => element["displayName"] == "Shared Height");
            attributes["Shared Height"] = sheight["displayValue"];
            dynamic swidth = props.firstWhere(
                (element) => element["displayName"] == "Shared Width");
            attributes["Shared Width"] = swidth["displayValue"];
            dynamic sdepth = props.firstWhere(
                (element) => element["displayName"] == "Shared Depth");
            attributes["Shared Depth"] = sdepth["displayValue"];
          } catch (ex) {}
        case "Windows":
          dynamic height = props
              .firstWhere((element) => element["displayName"] == "W_Height");
          attributes["Height"] = height["displayValue"];
          dynamic width = props
              .firstWhere((element) => element["displayName"] == "W_Width");
          attributes["Width"] = width["displayValue"];
          dynamic sillHeight = props
              .firstWhere((element) => element["displayName"] == "Sill Height");
          attributes["Sill Height"] = sillHeight["displayValue"];
          break;
        default:
      }
    }

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
                  item["name"],
                  style: AppTextStyles.display14w500,
                ),
              ),
            ),
            if (booleanCat.any((element) => element.contains(categoryName)))
              _YesORNoWrapper(
                initialValue: true,
                elementID: "12393",
                onClickWhenDisabled: () {},
                onSelectionChanged: (val) {},
              )
          ],
        ),
        //Properties!
        if (attributes.isNotEmpty) ...[
          for (String key in attributes.keys) ...[
            _AttributeWidget(
              entry: key,
              value: attributes[key],
            )
          ]
        ],
        Divider(
          height: 32,
          color: AppColors.dividerColor,
        ),
      ],
    );
  }
}

class _AttributeWidget extends StatelessWidget {
  String entry;
  dynamic value;
  _AttributeWidget({
    required this.entry,
    required this.value,
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
        if (true) ...[
          Text(
            entry,
            style: AppTextStyles.display14w500,
          ),
          SizedBox(
            height: 8,
          ),
        ],
        ItemDataField(
          value: value is double
              ? (value as double).toStringAsFixed(2)
              : value.toString(),
        )
      ],
    );
  }
}

class ItemDataField extends StatefulWidget {
  String value;

  ItemDataField({
    super.key,
    required this.value,
  });

  @override
  State<ItemDataField> createState() => _ItemDataFieldState();
}

class _ItemDataFieldState extends State<ItemDataField> {
  late TextEditingController controller =
      TextEditingController(text: '${widget.value}');

  final FocusNode focusNode = FocusNode();

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
        // key: Key('${"localCopyOfEntry.key"}_datafield'),
        // childKey: '${"localCopyOfEntry.key"}_datafield_child',
        controller: controller,
        hintText: 'Enter value',
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
