import 'package:flutter/material.dart';
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
        // controller.evaluateJavascript(source: "javascript:miguelfunction()");
      },
    );
  }
}
