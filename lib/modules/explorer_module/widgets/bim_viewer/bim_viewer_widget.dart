import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
    return InAppWebView(
      onConsoleMessage: (controller, consoleMessage) {
        print(consoleMessage.message);
      },
      initialUrlRequest: URLRequest(
          url: WebUri.uri(
              Uri.parse("http://localhost:8080/assets/wwwroot/index.html"))),
      onWebViewCreated: (controller) {
        controller.addJavaScriptHandler(
          handlerName: "test1",
          callback: (arguments) {
            // print(arguments);
            return "you doing well here!!";
          },
        );
      },
      onLoadStop: (controller, url) {
        //1) here we trigger the first view initialization!!
        print("we are here miguel");
        String unitFloorPlanPath =
            '"resource/Unit_Floor_Plan.pdf"'; //initial path!
        controller.evaluateJavascript(
            source:
                'initViewer(document.getElementById("topViewer"),${unitFloorPlanPath},topViewer)');
      },
    );
  }
}
