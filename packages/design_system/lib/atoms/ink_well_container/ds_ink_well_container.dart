import 'package:flutter/material.dart';

class DSInkWellContainer extends StatelessWidget {
  const DSInkWellContainer({
    required this.child,
    this.height,
    this.width,
    this.onTap,
    this.padding,
    this.decoration,
    super.key,
  });

  final Widget child;
  final double? height;
  final double? width;
  final void Function()? onTap;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final borderRadius = decoration?.borderRadius is BorderRadius
        ? (decoration?.borderRadius as BorderRadius?)
        : null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Ink(
          height: height,
          width: width,
          decoration: decoration,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
