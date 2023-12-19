import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/viewer_bloc.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/viewer_states.dart';
import 'package:minisitewalkapp/modules/explorer_module/models/autodesk_views.dart';
import 'package:minisitewalkapp/modules/explorer_module/models/room_model.dart';
import 'package:minisitewalkapp/modules/unit_plans/models/unit_plan.dart';

class BimViewerWidget extends StatefulWidget {
  @override
  State<BimViewerWidget> createState() => _BimViewerWidgetState();
}

class _BimViewerWidgetState extends State<BimViewerWidget> {
  InAppLocalhostServer localServer =
      InAppLocalhostServer(); //documentRoot: "./" leave it like that

  @override
  void initState() {
    //a) start local server
    startServer();

    super.initState();
  }

  startServer() async {
    await localServer.start();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewerBloc, ViewerState>(
      builder: (context, state) {
        ViewerBloc viewerBloc = context.read<ViewerBloc>();
        UnitPlan selectedUnitPlan = viewerBloc.unitPlan;

        return InAppWebView(
          onConsoleMessage: (controller, consoleMessage) {
            print(consoleMessage.message);
          },
          initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(
                  "http://localhost:8080/assets/wwwroot/index.html"))),
          onWebViewCreated: (controller) {
            controller.addJavaScriptHandler(
              handlerName: "roomSelected",
              callback: (arguments) {
                //i) get id
                int dbId = arguments[0];

                //search the list of views to display in forge viewers || and display 2 viewers
                //ii) get the room
                Room theroom =
                    viewerBloc.roomItems.firstWhere((room) => room.id == dbId);

                //iii) search the viewables in from the props
                //wrong data! it's passing other floors and elevations!
                // List<String> viewables = theroom.props
                //     .where((prop) => prop["displayName"] == "viewable_in")
                //     .map<String>((prop) => prop["displayValue"])
                //     .toList();

                List<AutodeskView> viewables = viewerBloc.autodeskViews
                    .where((view) => view.name.length > theroom.name.length)
                    .where((view) =>
                        view.name.substring(0, theroom.name.length) ==
                        theroom.name)
                    .toList();
                AutodeskView floorPlan = viewables.firstWhere(
                    (element) => element.name.toLowerCase().contains("floor"));
                List<AutodeskView> elevations = viewables
                    .where((element) =>
                        element.name.toLowerCase().contains("elevation"))
                    .toList();

                //search the list of categories that are visible on the views!

                //encode the data to be sent to js side
                Map<String, dynamic> jsonData = {
                  "floorPlan": jsonEncode(floorPlan),
                  "elevations": jsonEncode(elevations)
                };
                return jsonEncode(jsonData);

                //toggle the panel room
              },
            );
          },
          onLoadStop: (controller, url) {
            //1) here we trigger the first view initialization!!
            String unitFloorPlanPath =
                '"resource/${selectedUnitPlan.assetPath}/Unit_Floor_Plan.pdf"'; //initial path!
            controller.evaluateJavascript(
                source:
                    'initTopViewer(document.getElementById("topViewer"),${unitFloorPlanPath},onFirstSelectionChanged)');
          },
        );
      },
    );
  }
}
