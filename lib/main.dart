import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minisitewalkapp/core/utils/initialize_dependencies.dart';
import 'package:minisitewalkapp/modules/home/screens/init_screen.dart';

void main() async {
  //required by flutter
  WidgetsFlutterBinding.ensureInitialized();
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
