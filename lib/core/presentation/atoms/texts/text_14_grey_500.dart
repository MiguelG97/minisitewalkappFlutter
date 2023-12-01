import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';

class Text14grey500 extends StatelessWidget {
  final String data;

  const Text14grey500(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.grey,
      ),
    );
  }
}
