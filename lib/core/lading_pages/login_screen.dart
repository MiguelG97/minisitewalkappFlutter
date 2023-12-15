import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LogginScreen extends StatefulWidget {
  @override
  State<LogginScreen> createState() => _LogginScreenState();
}

class _LogginScreenState extends State<LogginScreen> {
  String url =
      "https://renovate.tailorbird.com/callback"; //https://dev-v2.tailorbirdhomes.com/   I dont have acc for this page!!
  late InAppWebViewController webViewController;

  bool isLoading = false;
  String? token;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(url)),
          onLoadStart: (controller, url) {
            setState(() {
              isLoading = true;
            });
          },
          onLoadStop: (controller, url) {
            setState(() {
              isLoading = false;
              // print(url);
            });
          },
          onWebViewCreated: (controller) {
            webViewController = controller;
            webViewController.clearCache();
            webViewController.webStorage.localStorage.clear();
          },
          shouldInterceptFetchRequest: (controller, fetchRequest) async {
            if (token == null) {
              final mtoken = await webViewController.webStorage.localStorage
                  .getItem(key: "access_token");

              if (mtoken != null || mtoken != "") {
                token = mtoken;
                List<WebStorageItem> items =
                    await webViewController.webStorage.localStorage.getItems();
                String? refreshToken;
                for (final item in items) {
                  refreshToken = checkAndGetRefreshToken(item.value);
                  if (refreshToken != null) {
                    break;
                  }
                }
                //refresh token was not stored in the page I ve access to it

                // initBloc.add(LoginEvent(mtoken: token!));
              }
            }
            return fetchRequest;
          },
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  String? checkAndGetRefreshToken(dynamic value) {
    try {
      var json = {};
      if (value is Map) {
        json = value;
      } else if (value is String) {
        json = jsonDecode(value);
      }
      final refreshToken = json['body']?['refresh_token'];
      return refreshToken;
    } catch (e) {
      return null;
    }
  }
}
