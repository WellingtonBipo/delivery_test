import 'package:design_system/atoms/shimmer/ds_shimmer.dart';
import 'package:design_system/atoms/text/ds_text.dart';
import 'package:flutter/material.dart';

class DSRate extends StatelessWidget {
  const DSRate({
    required this.rate,
    required this.typography,
    this.isLoading = false,
    this.color,
    super.key,
  });

  final double rate;
  final Color? color;
  final DSTextTypography typography;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return DSShimmer(
      enabled: isLoading,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: (typography.toTextStyle().fontSize ?? 12) * 1.2,
            color: const Color.fromARGB(255, 251, 193, 38),
          ),
          const SizedBox(width: 2),
          DSText(
            rate.toStringAsFixed(1),
            typography: typography,
            color: color,
          ),
        ],
      ),
    );
  }
}
