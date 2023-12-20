import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CheckMeasureState {}

class NoSelection extends CheckMeasureState {}

class NewSelection extends CheckMeasureState {
  int dbId;
  NewSelection({required this.dbId});
}

abstract class CheckMeasureEvent {}

class ItemSelectedEvent extends CheckMeasureEvent {
  int dbId;
  ItemSelectedEvent({required this.dbId});
}

class SelectionRefreshedEvent extends CheckMeasureEvent {}

class CheckMeasureBloc extends Bloc<CheckMeasureEvent, CheckMeasureState> {
  CheckMeasureBloc() : super(NoSelection()) {
    on<ItemSelectedEvent>(
      (ItemSelectedEvent event, Emitter<CheckMeasureState> emit) {
        emit(NewSelection(dbId: event.dbId));
      },
    );
    on<SelectionRefreshedEvent>(
        (SelectionRefreshedEvent event, Emitter<CheckMeasureState> emit) {
      emit(NoSelection());
    });
  }
}
