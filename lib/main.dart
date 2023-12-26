import 'dart:io';

import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:minisitewalkapp/core/utils/initialize_dependencies.dart';
import 'package:minisitewalkapp/modules/unit_plans/screens/unit_plans.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  //required by flutter
  WidgetsFlutterBinding.ensureInitialized();
  InAppLocalhostServer localServer = InAppLocalhostServer();
  await localServer.start();

  DownloadAssetsController downloadAssetController = DownloadAssetsController();
  await downloadAssetController.init(assetDir: "assets/wwwroot");

  Directory directory = await getApplicationDocumentsDirectory();
  // print(directory.path);
  try {
    bool result = await downloadAssetController
        .assetsFileExists("/google-76517_1280.png");
    if (!result) {
      dynamic resp = await downloadAssetController.startDownload(
        assetsUrls: [
          "https://cdn.pixabay.com/photo/2013/01/29/00/47/google-76517_1280.png"
        ],
      );
      print(resp);
      print(downloadAssetController.assetsDir);
    } else {
      ByteData sth = await rootBundle
          .load(downloadAssetController.assetsDir! + "/google-76517_1280.png");
      print(sth);
    }
  } catch (e) {
    print(e);
  }

  // List<FileSystemEntity> assetFiles =
  //     Directory(downloadAssetController.assetsDir!).listSync(recursive: true);
  // for (FileSystemEntity entity in assetFiles) {
  //   if (entity is File) {
  //     print(entity.path);
  //   } else if (entity is Directory) {
  //     Directory dirEnt = entity as Directory;
  //     List<FileSystemEntity> subAssetFiles = dirEnt.listSync();
  //     for (FileSystemEntity subEntity in subAssetFiles) {
  //       print(subEntity.path);
  //     }
  //   }
  // }

  // print(downloadAssetController.assetsDir);
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
