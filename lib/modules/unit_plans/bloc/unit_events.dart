import 'package:minisitewalkapp/modules/unit_plans/models/unit_plan.dart';

abstract class UnitEvent {}

class UnitSelectionStarted extends UnitEvent {
  UnitPlan unitplan;
  UnitSelectionStarted({required this.unitplan});
}
