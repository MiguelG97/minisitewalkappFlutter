abstract class ViewerState {}

class ViewNotInitialized extends ViewerState {}

class ViewPreInitialized extends ViewerState {
  List<dynamic> roomItems;
  List<dynamic> roomCategories;
  bool isLandingPage = true;
  ViewPreInitialized({required this.roomItems, required this.roomCategories});
}

class RoomPanelOpened extends ViewerState {}
