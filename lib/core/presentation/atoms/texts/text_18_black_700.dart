import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';

class Text18Black700 extends StatelessWidget {
  final String data;

  const Text18Black700(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }
}
