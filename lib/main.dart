import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:minisitewalkapp/core/utils/initialize_dependencies.dart';
import 'package:minisitewalkapp/modules/unit_plans/screens/unit_plans.dart';

void main() async {
  //required by flutter
  WidgetsFlutterBinding.ensureInitialized();
  InAppLocalhostServer localServer = InAppLocalhostServer();
  await localServer.start();
  //dependency injections
  await initialiseDependencies();

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((value) => runApp(SiteWalkApp()));
}

class SiteWalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitScreen(),
    );
  }
}
