import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? childKey;
  final String? hintText;
  final TextInputType inputType;
  final Color fillColor;
  final bool hideBorder;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.inputType = TextInputType.text,
    this.fillColor = const Color(0xFFF6F6F7),
    this.hideBorder = false,
    this.onChanged,
    this.focusNode,
    this.childKey,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      key: Key(childKey ?? ''),
      enabled: enabled,
      focusNode: focusNode,
      controller: controller,
      keyboardType: inputType,
      onChanged: onChanged,
      inputFormatters: getInputFormatters(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF757575)),
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hideBorder
              ? BorderSide.none
              : BorderSide(
                  width: 2,
                  color: AppColors.dividerColor,
                ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hideBorder
              ? BorderSide.none
              : BorderSide(
                  width: 2,
                  color: AppColors.dividerColor,
                ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hideBorder
              ? BorderSide.none
              : const BorderSide(
                  width: 2,
                  color: AppColors.lightBlue,
                ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  List<TextInputFormatter> getInputFormatters() {
    if (inputType == const TextInputType.numberWithOptions(decimal: true)) {
      return [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}'))];
    } else if (inputType == TextInputType.number) {
      return [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))];
    }
    return [];
  }
}
