import 'package:design_system/ds_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DSShimmer extends StatelessWidget {
  const DSShimmer({
    required this.child,
    this.enabled = true,
    super.key,
  });

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    return Shimmer.fromColors(
      baseColor: DSTheme.of(context).colors.contentSecondary,
      highlightColor: DSTheme.of(context).colors.scaffoldBackground,
      child: child,
    );
  }
}
