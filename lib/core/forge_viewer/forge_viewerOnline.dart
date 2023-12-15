import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:minisitewalkapp/core/presentation/atoms/icons/ic_profile.dart';
import 'package:minisitewalkapp/core/presentation/molecules/app_bars/app_bar_with_leading_icon.dart';

class ForgeViewerOnline extends StatefulWidget {
  @override
  State<ForgeViewerOnline> createState() => _ForgeViewerOnlineState();
}

class _ForgeViewerOnlineState extends State<ForgeViewerOnline> {
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
              url: WebUri("https://minisitewalkappapi.onrender.com/"))),
    ); //https://minisitewalkapp.vercel.app/ (with svf in local file)
  }
}
