import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/viewer_events.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/viewer_states.dart';

class ViewerBloc extends Bloc<ViewerEvent, ViewerState> {
  ViewerBloc() : super(ViewNotInitialized()) {
    on<ViewerPreInitializedScreen>(onViewPreInitialized);

    add(ViewerPreInitializedScreen());
  }
  onViewPreInitialized(
      ViewerPreInitializedScreen event, Emitter<ViewerState> emit) async {
    String data =
        await rootBundle.loadString("assets/wwwroot/resource/viewerDB.json");

    dynamic jsonViewer = jsonDecode(data);
    List<dynamic> roomItems = jsonViewer["rooms"];
    List<dynamic> roomCategories = jsonViewer["autodeskCategories"];
    emit(ViewPreInitialized(
        roomItems: roomItems, roomCategories: roomCategories));
  }
}
