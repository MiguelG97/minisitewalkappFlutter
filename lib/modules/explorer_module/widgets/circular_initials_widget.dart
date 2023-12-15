import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';

class CircularInitialsWidget extends StatelessWidget {
  final Color bgColor;
  final String text;
  final Color textColor;
  final double? size;
  const CircularInitialsWidget({
    super.key,
    required this.bgColor,
    required this.text,
    required this.textColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 40,
      height: size ?? 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTextStyles.display14w700.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
