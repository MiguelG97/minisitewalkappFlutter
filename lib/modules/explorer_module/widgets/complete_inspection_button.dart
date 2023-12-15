import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';

class CompleteInspectionButton extends StatelessWidget {
  final Function() onPressed;
  final Color bgColor;
  final String text;
  const CompleteInspectionButton({
    super.key,
    required this.onPressed,
    required this.bgColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        backgroundColor: bgColor.withOpacity(
          1,
        ),
      ),
      onPressed: onPressed,
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 16,
      ),
      label: Text(
        text,
        style: AppTextStyles.display14w500.copyWith(color: Colors.white),
      ),
    );
  }
}
