import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';

class DividerBase extends StatelessWidget {
  final double? height;

  const DividerBase({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 1,
      color: AppColors.lightGrey2,
    );
  }
}
