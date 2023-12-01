import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  final double height;
  const VSpace({super.key, required this.height});

  factory VSpace.h8() => const VSpace(height: 8);

  factory VSpace.h12() => const VSpace(height: 12);

  factory VSpace.h24() => const VSpace(height: 24);

  factory VSpace.h16() => const VSpace(height: 16);

  factory VSpace.h32() => const VSpace(height: 32);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
