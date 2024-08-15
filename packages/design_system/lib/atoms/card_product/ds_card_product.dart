import 'package:design_system/atoms/shimmer/ds_shimmer.dart';
import 'package:design_system/atoms/text/ds_text.dart';
import 'package:design_system/ds_theme.dart';
import 'package:flutter/material.dart';

class DSCardProduct extends StatelessWidget {
  const DSCardProduct({
    required this.text,
    required this.rate,
    required this.imageUrl,
    required this.color,
    this.onTap,
    super.key,
  }) : isLoading = false;

  const DSCardProduct.loading({super.key})
      : text = '',
        rate = 0,
        imageUrl = '',
        color = Colors.grey,
        onTap = null,
        isLoading = true;

  final String text;
  final double rate;
  final String imageUrl;
  final Color color;
  final void Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return DSShimmer(
      enabled: isLoading,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 40,
              ),
              child: isLoading ? null : Image.network(imageUrl),
            ),
            _Rate(rate),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DSText(
                text,
                textAlign: TextAlign.center,
                typography: const DSTextTypography.header4(),
                color: DSTheme.of(context).colors.textPrimaryAlwaysLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Rate extends StatelessWidget {
  const _Rate(this.rate);

  final double rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.only(right: 10, top: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 15,
            color: Color.fromARGB(255, 251, 193, 38),
          ),
          const SizedBox(width: 2),
          DSText(
            rate.toStringAsFixed(1),
            typography: const DSTextTypography.header4(),
            color: DSTheme.of(context).colors.textPrimaryAlwaysLight,
          ),
        ],
      ),
    );
  }
}
