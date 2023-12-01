import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minisitewalkapp/core/constants/asset_paths.dart';

class IcSort extends StatelessWidget {
  const IcSort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetPaths.icSort);
  }
}
