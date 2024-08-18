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
      baseColor: switch (DSTheme.of(context).platformBrightness) {
        Brightness.light => const Color.fromARGB(255, 245, 245, 245),
        Brightness.dark => const Color.fromARGB(255, 35, 35, 35),
      },
      highlightColor: DSTheme.of(context).colors.scaffoldBackground,
      child: child,
    );
  }
}
