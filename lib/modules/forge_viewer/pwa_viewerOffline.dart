import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:minisitewalkapp/core/presentation/atoms/icons/ic_profile.dart';
import 'package:minisitewalkapp/core/presentation/molecules/app_bars/app_bar_with_leading_icon.dart';

class PWAViewer extends StatefulWidget {
  @override
  State<PWAViewer> createState() => _PWAViewerState();
}

class _PWAViewerState extends State<PWAViewer> {
  @override
  Widget build(BuildContext context) {
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
          onWebViewCreated: (controller) {},
          initialUrlRequest: URLRequest(
              url:
                  Uri.parse("https://tb-disconnected-workflow.onrender.com/"))),
    ); //https://minisitewalkapp.vercel.app/ (with svf in local file)
  }
}
