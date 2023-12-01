import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';

class IcProfile extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final String name;
  final double? fontSize;
  final FontWeight? fontWeight;

  const IcProfile({
    Key? key,
    this.height,
    this.width,
    this.foregroundColor,
    this.backgroundColor,
    this.name = '',
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 42,
      width: width ?? 42,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.blueCDE8F5,
        borderRadius: BorderRadius.circular(50),
      ),
      child: name.isNotEmpty
          ? Center(
              child: Text(
                name.characters.take(2).toString().toUpperCase(),
                style: AppTextStyles.display18w500.copyWith(
                  color: foregroundColor ?? AppColors.lightBlue,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            )
          : Icon(
              Icons.person,
              color: foregroundColor ?? AppColors.lightBlue,
            ),
    );
  }
}
