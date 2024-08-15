import 'package:design_system/atoms/shimmer/ds_shimmer.dart';
import 'package:design_system/atoms/text/ds_text.dart';
import 'package:design_system/ds_theme.dart';
import 'package:flutter/material.dart';

class DSCardCategory extends StatelessWidget {
  const DSCardCategory({
    required this.text,
    required this.imageUrl,
    this.onTap,
    super.key,
  }) : isLoading = false;

  const DSCardCategory.loading({super.key})
      : isLoading = true,
        imageUrl = '',
        text = 'category',
        onTap = null;

  final bool isLoading;
  final String text;
  final String imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const size = 60.0;
    return Column(
      children: [
        DSShimmer(
          enabled: isLoading,
          child: Container(
            height: size,
            width: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: DSTheme.of(context).colors.contentPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: isLoading
                ? null
                : Image.network(
                    imageUrl,
                    height: 40,
                  ),
          ),
        ),
        const SizedBox(height: 5),
        DSText(
          text,
          isLoading: isLoading,
          typography: const DSTextTypography.contentTitle2(),
        ),
      ],
    );
  }
}
