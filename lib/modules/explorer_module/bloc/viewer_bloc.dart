import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/viewer_events.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/viewer_states.dart';
import 'package:minisitewalkapp/modules/explorer_module/models/autodesk_categories.dart';
import 'package:minisitewalkapp/modules/explorer_module/models/autodesk_views.dart';
import 'package:minisitewalkapp/modules/explorer_module/models/room_model.dart';
import 'package:minisitewalkapp/modules/unit_plans/models/unit_plan.dart';

class ViewerBloc extends Bloc<ViewerEvent, ViewerState> {
  late UnitPlan unitPlan;
  late String data;
  late List<Room> roomItems;
  late List<AutodeskCategory> roomCategories;
  late List<AutodeskView> autodeskViews;
  late InAppWebViewController controller;
  late ScrollController categoryItemsPanelScroller;
  bool elevsDisplayed = false;

  ViewerBloc({unitplan}) : super(ViewNotInitialized()) {
    unitPlan = unitplan;
    on<ViewerPreInitializedScreen>(onViewPreInitialized);
    on<ViewerElevationsDisplayed>(onViewerElevationsDisplayed);

    add(ViewerPreInitializedScreen());
  }
  onViewPreInitialized(
      ViewerPreInitializedScreen event, Emitter<ViewerState> emit) async {
    data = await rootBundle.loadString(
        "assets/wwwroot/resource/${unitPlan.assetPath}/viewerDB.json");

    Map<String, dynamic> jsonViewer = jsonDecode(data);
    roomItems = List<Room>.from(
        jsonViewer["rooms"]!.map((json) => Room.fromJson(json)));

    roomCategories = List<AutodeskCategory>.from(
        jsonViewer["autodeskCategories"]!
            .map((json) => AutodeskCategory.fromJson(json)));
    autodeskViews = List<AutodeskView>.from(jsonViewer["autodeskViews"]!
        .map((json) => AutodeskView.fromJson(json)));

    emit(ViewPreInitialized(
        roomItems: roomItems, roomCategories: roomCategories));
  }

  onViewerElevationsDisplayed(
      ViewerElevationsDisplayed event, Emitter<ViewerState> emit) {
    emit(ViewDisplayingElev(
        roomItems: roomItems, roomCategories: roomCategories));
  }
}
