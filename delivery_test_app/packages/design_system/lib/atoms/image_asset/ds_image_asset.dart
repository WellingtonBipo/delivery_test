import 'package:flutter/material.dart';

class DSImageAsset extends StatelessWidget {
  const DSImageAsset({
    required this.asset,
    this.height,
    this.width,
    this.color,
    super.key,
  });

  final String asset;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      height: height,
      width: width,
      color: color,
      package: 'design_system',
    );
  }
}
