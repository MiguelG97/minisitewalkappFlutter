import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BimViewerWebView extends StatefulWidget {
  const BimViewerWebView({super.key});

  @override
  State<BimViewerWebView> createState() => _BimViewerWebViewState();
}

class _BimViewerWebViewState extends State<BimViewerWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = WebViewController.fromPlatformCreationParams(
        PlatformWebViewControllerCreationParams());
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {},
      ))
      ..loadFlutterAsset("assets/js-forge-viewer/index.html");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
