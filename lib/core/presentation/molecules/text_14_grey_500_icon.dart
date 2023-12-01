import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/presentation/atoms/texts/text_14_grey_500.dart';

class Text14grey500Icon extends StatelessWidget {
  final String data;
  final Widget icon;

  const Text14grey500Icon(
    this.data, {
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text14grey500(data),
        const SizedBox(
          width: 8,
        ),
        Container(
          child: icon,
        ),
      ],
    );
  }
}
