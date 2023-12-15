import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';

class RoundRectangleChip extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final String text;

  const RoundRectangleChip({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
        label: Text(
          text,
          style: AppTextStyles.display14w400.copyWith(
            color: textColor ?? AppColors.green00B779,
          ),
        ),

        // Text14grey400('Completed'),
        backgroundColor: backgroundColor ?? AppColors.lightGreen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ));
  }
}
