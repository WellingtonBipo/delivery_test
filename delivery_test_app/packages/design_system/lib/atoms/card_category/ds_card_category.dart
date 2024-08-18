import 'package:design_system/atoms/ink_well_container/ds_ink_well_container.dart';
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
        text = 'some ',
        onTap = null;

  const DSCardCategory.error({super.key})
      : isLoading = null,
        imageUrl = '',
        text = 'some ',
        onTap = null;

  final bool? isLoading;
  final String text;
  final String imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const size = 60.0;
    return Column(
      children: [
        DSShimmer(
          enabled: isLoading ?? false,
          child: DSInkWellContainer(
            onTap: onTap,
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: DSTheme.of(context).colors.contentPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              child: isLoading == null
                  ? Icon(
                      Icons.error,
                      size: 30,
                      color: DSTheme.of(context).colors.textPrimary,
                    )
                  : isLoading!
                      ? null
                      : Image.network(
                          imageUrl,
                          height: 40,
                        ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        DSText(
          isLoading == null ? '---' : text,
          isLoading: isLoading ?? false,
          typography: const DSTextTypography.contentTitle2(),
        ),
      ],
    );
  }
}
