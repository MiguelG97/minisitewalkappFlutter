import 'package:minisitewalkapp/core/presentation/molecules/search_with_filter/filter_search_model.dart';

class InspectionPhaseConst {
  InspectionPhaseConst._();

  static const inspectionDueDate = 'inspection_due_date';
  static const inspectionStatus = 'inspection_status';
  static const inspectionPhase = 'inspection_phase';

  static List<FilterSearchModel> filterSearch = [
    FilterSearchModel(
      'Inspection phase',
      inspectionPhase,
      FilterSearchType.inspectionPhase,
    ),
    FilterSearchModel(
      'Due Date',
      inspectionDueDate,
      FilterSearchType.dueDate,
    ),
    FilterSearchModel(
      'Status',
      inspectionStatus,
      FilterSearchType.status,
    ),
  ];

  static const howToUse = '''
## Due-diligence

- I should Select a FP from the existing list
- Once selected, trigger the action button to [create] a child FP as
duplicate of its parent and auto-numerate its name: for example,
C1_Oasis.1

Because this would allow me to capture inspection information for the
floorplans that did not initially exist and I discovered during inspection.

**Definition of Nested FPs**: when the layout is the same, but for example
the linear length of cabinets varies by >6 inches.

## Pre-construction

- User would be asked to select one from the list of FPs
- Give it a name

A new row would be added to the FP list
Because this would allow me to capture inspection information for the
floorplans that did not initially exist and I discovered during inspection.

**Definition of Mutant Floorplans**:
when the layout varies substantially from the expected layout (i.e. we
expected a U-shaped kitchen and instead observed an L shaped).
 ''';
}
