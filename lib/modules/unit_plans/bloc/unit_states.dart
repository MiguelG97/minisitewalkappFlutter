import 'package:minisitewalkapp/modules/unit_plans/models/unit_plan.dart';

abstract class UnitState {}

class UnitNotSelected extends UnitState {}

class UnitSelectionInProgress extends UnitState {
  UnitPlan unitPlan;
  UnitSelectionInProgress({required this.unitPlan});
}
