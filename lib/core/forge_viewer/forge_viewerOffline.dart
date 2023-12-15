import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minisitewalkapp/core/constants/asset_paths.dart';
import 'package:minisitewalkapp/core/presentation/atoms/icons/ic_profile.dart';
import 'package:minisitewalkapp/core/presentation/molecules/app_bars/app_bar_with_leading_icon.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForgeViewer extends StatefulWidget {
  @override
  State<ForgeViewer> createState() => _ForgeViewerState();
}

//in app web view
class _ForgeViewerState extends State<ForgeViewer> {
  final InAppLocalhostServer localhostServer =
      new InAppLocalhostServer(port: 5123);
  late InAppWebViewController webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localhostServer.start();
  }

  @override
  Widget build(BuildContext context) {
    //https://minisitewalkapp.vercel.app/
    return Scaffold(
        appBar: AppBarWithLeadingIcon(
          trailingWidgets: [
            InkWell(
              onTap: () {
                final mediaQuery = MediaQuery.of(context);
                //icon profile ...
              },
              child: const IcProfile(),
            )
          ],
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri("http://localhost:5123/assets/wwwroot/index.html"),
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;

            // webViewController.addJavaScriptHandler(
            //   handlerName: "report bug",
            //   callback: (arguments) {
            //     print(arguments);
            //   },
            // );
          },
          onLoadStart: (controller, url) {},
          onLoadStop: (controller, url) async {
            //not working!
            // var res = await webViewController.injectJavascriptFileFromUrl(
            //     urlFile:
            //         Uri.parse("http://localhost:8080/assets/wwwroot/main.js"));
          },
          onConsoleMessage: (controller, consoleMessage) {
            print(consoleMessage);
          },
        ));
  }
}

//web view flutter
// class _ForgeViewerState extends State<ForgeViewer> {
//   late WebViewController controller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (url) {
//             // print("Hola miguel 1");
//           },
//           onPageFinished: (url) {
//             // print("miguel is: " + url);
//             if (url.endsWith("index.html")) {
//               // controller.runJavaScript('''console.log("\Miguel\")''');
//               // controller.loadFlutterAsset("assets/js-forge-viewer/index.html");
//               // controller.runJavaScript(scriptJS);
//               //               controller.runJavaScript(
//               //                   '''const sth = document.getElementById("preview");
//               // sth.innerText = "miguel hola";''');
//             }
//           },
//           onWebResourceError: (WebResourceError error) {},
//         ),
//       )
//       ..loadFlutterAsset(AssetPaths.indexHtml);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBarWithLeadingIcon(
//           trailingWidgets: [
//             InkWell(
//               onTap: () {
//                 final mediaQuery = MediaQuery.of(context);
//                 //icon profile ...
//               },
//               child: const IcProfile(),
//             )
//           ],
//         ),
//         body: WebViewWidget(controller: controller));
//   }
// }
