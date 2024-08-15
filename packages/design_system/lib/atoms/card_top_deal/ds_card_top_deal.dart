import 'package:design_system/atoms/atoms.dart';
import 'package:design_system/atoms/shimmer/ds_shimmer.dart';
import 'package:design_system/ds_theme.dart';
import 'package:flutter/material.dart';

class DSCardTopDeal extends StatelessWidget {
  const DSCardTopDeal({
    required this.title,
    required this.buttonText,
    required this.imageUrl,
    required this.colorBackground,
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

  final bool isLoading;
  final String? header;
  final String title;
  final String buttonText;
  final void Function()? onTapButton;
  final String imageUrl;
  final Color colorBackground;

  @override
  Widget build(BuildContext context) {
    final headerWidget = DSText(
      header ?? '',
      color: DSTheme.of(context).colors.textSecondaryAlwaysLight,
      typography: const DSTextTypography.header4(),
    );

    return DSShimmer(
      enabled: isLoading,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colorBackground,
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
                  typography: const DSTextTypography.header2(),
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
                      color: DSTheme.of(context).colors.auxiliarBrandPrimary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: DSText(
                      buttonText,
                      color: DSTheme.of(context).colors.brandPrimary,
                      typography: const DSTextTypography.header3(),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: isLoading
                    ? Container(
                        height: 125,
                        width: 125,
                        color: DSTheme.of(context).colors.contentSecondary,
                      )
                    : Image.network(
                        imageUrl,
                        height: 125,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
