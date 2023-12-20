import 'package:minisitewalkapp/modules/explorer_module/models/autodesk_categories.dart';
import 'package:minisitewalkapp/modules/explorer_module/models/room_model.dart';

abstract class ViewerState {}

class ViewNotInitialized extends ViewerState {}

class ViewPreInitialized extends ViewerState {
  List<Room> roomItems;
  List<AutodeskCategory> roomCategories;
  bool isLandingPage = true;
  ViewPreInitialized({required this.roomItems, required this.roomCategories});
}

class ViewDisplayingElev extends ViewerState {
  bool forceToHide = true;
  List<Room> roomItems;
  List<AutodeskCategory> roomCategories;
  ViewDisplayingElev({required this.roomItems, required this.roomCategories});
}

class RoomPanelOpened extends ViewerState {}
