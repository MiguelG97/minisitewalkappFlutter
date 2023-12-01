import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/presentation/molecules/search_bar.dart'
    as sb;

class SearchBarWithFilter extends StatelessWidget {
  final ValueChanged<String>? onSearchTextChanged;
  final List<LabelValueModel>? filterFields;
  final ValueChanged<String>? onFilterSelected;
  final String? searchBarHintText;
  final int? debounceTime;

  const SearchBarWithFilter({
    Key? key,
    this.onSearchTextChanged,
    this.filterFields,
    this.onFilterSelected,
    this.searchBarHintText,
    this.debounceTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterFields = this.filterFields;
    return Row(
      children: [
        Expanded(
          child: sb.SearchBar(
            searchBarHintText: searchBarHintText,
            onTextChanged: onSearchTextChanged,
            debounceTime: debounceTime,
          ),
        ),
        if (filterFields != null)
          const SizedBox(
            width: 24,
          ),
        if (filterFields != null)
          PopupMenuButton(
            icon: const Icon(
              Icons.filter_list,
              color: AppColors.greyIcon,
            ),
            itemBuilder: (BuildContext context) {
              return filterFields
                  .map((item) => PopupMenuItem(
                        value: item.value,
                        child: Text(item.label),
                      ))
                  .toList();
            },
            onSelected: (selectedOption) {
              onFilterSelected?.call(selectedOption);
            },
            tooltip: 'Filter',
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(color: AppColors.lightGrey2),
            ),
          ),
      ],
    );
  }
}

abstract class LabelValueModel {
  final String label;
  final String value;

  LabelValueModel(this.label, this.value);
}
