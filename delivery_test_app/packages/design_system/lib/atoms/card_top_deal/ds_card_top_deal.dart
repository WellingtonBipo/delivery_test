import 'package:design_system/atoms/atoms.dart';
import 'package:design_system/atoms/shimmer/ds_shimmer.dart';
import 'package:design_system/ds_theme.dart';
import 'package:flutter/material.dart';

class DSCardTopDeal extends StatelessWidget {
  const DSCardTopDeal({
    required this.title,
    required this.buttonText,
    required this.imageUrl,
    required Color this.colorBackground,
    this.onTapButton,
    this.header,
    super.key,
  }) : isLoading = false;

  const DSCardTopDeal.loading({
    super.key,
  })  : header = '',
        title = '',
        buttonText = '',
        imageUrl = '',
        onTapButton = null,
        colorBackground = Colors.grey,
        isLoading = true;

  const DSCardTopDeal.error({
    super.key,
  })  : header = '',
        title = '',
        buttonText = '',
        imageUrl = '',
        onTapButton = null,
        colorBackground = null,
        isLoading = null;

  final bool? isLoading;
  final String? header;
  final String title;
  final String buttonText;
  final void Function()? onTapButton;
  final String imageUrl;
  final Color? colorBackground;

  @override
  Widget build(BuildContext context) {
    final headerWidget = DSText(
      header ?? '',
      color: DSTheme.of(context).colors.textSecondaryAlwaysLight,
      typography: const DSTextTypography.header5(),
    );

    return DSShimmer(
      enabled: isLoading ?? false,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colorBackground ?? DSTheme.of(context).colors.contentPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (header != null) headerWidget,
                DSText(
                  title,
                  typography: const DSTextTypography.header3(),
                  color: DSTheme.of(context).colors.textPrimaryAlwaysLight,
                ),
                if (header == null) headerWidget,
                const SizedBox(height: 10),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onTapButton,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: isLoading == null
                          ? Colors.transparent
                          : DSTheme.of(context).colors.auxiliarBrandPrimary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: DSText(
                      buttonText,
                      color: DSTheme.of(context).colors.brandPrimary,
                      typography: const DSTextTypography.header4(),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment:
                  isLoading == null ? Alignment.center : Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: isLoading == null ? 0 : 10),
                child: Container(
                  height: 125,
                  color: Colors.transparent,
                  child: isLoading == null
                      ? Icon(
                          Icons.error,
                          size: 40,
                          color: DSTheme.of(context).colors.textPrimary,
                        )
                      : isLoading!
                          ? null
                          : Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
