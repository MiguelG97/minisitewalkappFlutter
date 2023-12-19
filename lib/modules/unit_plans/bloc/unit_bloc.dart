import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:minisitewalkapp/modules/unit_plans/bloc/unit_events.dart';
import 'package:minisitewalkapp/modules/unit_plans/bloc/unit_states.dart';
import 'package:minisitewalkapp/modules/unit_plans/models/unit_plan.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  late UnitPlan currentUnitplan;

  UnitBloc() : super(UnitNotSelected()) {
    on<UnitSelectionStarted>(onUnitSelectionStarted);
  }
  onUnitSelectionStarted(UnitSelectionStarted event, Emitter<UnitState> emit) {
    currentUnitplan = event.unitplan;
    emit(UnitSelectionInProgress(unitPlan: event.unitplan));
  }
}
