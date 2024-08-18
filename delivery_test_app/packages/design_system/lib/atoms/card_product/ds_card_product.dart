import 'package:design_system/atoms/ink_well_container/ds_ink_well_container.dart';
import 'package:design_system/atoms/rate/ds_rate.dart';
import 'package:design_system/atoms/shimmer/ds_shimmer.dart';
import 'package:design_system/atoms/text/ds_text.dart';
import 'package:design_system/ds_theme.dart';
import 'package:flutter/material.dart';

class DSCardProduct extends StatelessWidget {
  const DSCardProduct({
    required this.text,
    required this.rate,
    required this.imageUrl,
    required Color this.color,
    this.onTap,
    this.onTapFavorite,
    this.isFavorite,
    this.heroTag,
    super.key,
  }) : isLoading = false;

  const DSCardProduct.loading({super.key})
      : text = '',
        rate = 0,
        imageUrl = '',
        color = null,
        onTap = null,
        onTapFavorite = null,
        isFavorite = null,
        heroTag = null,
        isLoading = true;

  const DSCardProduct.error({super.key})
      : text = '',
        rate = 0,
        imageUrl = '',
        color = null,
        onTap = null,
        onTapFavorite = null,
        isFavorite = null,
        heroTag = null,
        isLoading = null;

  final String text;
  final double rate;
  final String imageUrl;
  final Color? color;
  final void Function()? onTap;
  final void Function()? onTapFavorite;
  final bool? isLoading;
  final bool? isFavorite;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return DSShimmer(
      enabled: isLoading ?? false,
      child: DSInkWellContainer(
        onTap: onTap,
        decoration: BoxDecoration(
          color: color ?? DSTheme.of(context).colors.contentPrimaryAlwaysLight,
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
              child: (isLoading ?? true)
                  ? null
                  : heroTag == null
                      ? Image.network(imageUrl)
                      : Hero(
                          tag: heroTag!,
                          child: Image.network(imageUrl),
                        ),
            ),
            if (isLoading != null) ...[
              if (isFavorite != null)
                _Favorite(
                  isFavorite: isFavorite!,
                  onTap: onTapFavorite,
                ),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 10, top: 8),
                child: DSRate(
                  rate: rate,
                  color: DSTheme.of(context).colors.textPrimaryAlwaysLight,
                  typography: const DSTextTypography.header5(),
                ),
              ),
            ],
            if (isLoading == null)
              Align(
                child: Icon(
                  Icons.error,
                  size: 40,
                  color: DSTheme.of(context).colors.textPrimaryAlwaysLight,
                ),
              )
            else
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
                  typography: const DSTextTypography.header5(),
                  color: DSTheme.of(context).colors.textPrimaryAlwaysLight,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Favorite extends StatelessWidget {
  const _Favorite({
    required this.isFavorite,
    this.onTap,
  });

  final bool isFavorite;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: DSTheme.of(context).colors.brandPrimary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
