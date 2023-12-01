import 'package:minisitewalkapp/core/presentation/molecules/search_with_filter/search_bar_with_filter.dart';

enum FilterSearchType {
  dueDate,
  status,
  inspectionPhase,
}

class FilterSearchModel extends LabelValueModel {
  final FilterSearchType filterType;

  FilterSearchModel(super.label, super.value, this.filterType);
}
