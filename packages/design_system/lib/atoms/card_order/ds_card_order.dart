import 'package:design_system/atoms/image_asset/ds_image_asset.dart';
import 'package:design_system/atoms/text/ds_text.dart';
import 'package:design_system/ds_theme.dart';
import 'package:design_system/tokens/ds_image_assets.dart';
import 'package:flutter/material.dart';

class DSCardOrder extends StatelessWidget {
  const DSCardOrder({
    required this.type,
    required this.onTap,
    super.key,
  });

  final DSCardOrderType type;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    const padding = 16.0;
    String text;
    String imagePath;
    switch (type) {
      case DSCardOrderType.orderAgain:
        text = 'ORDER\nAGAIN';
        imagePath = DSImageAssets.basketShop;
        break;
      case DSCardOrderType.localShop:
        text = 'LOCAL\nSHOP';
        imagePath = DSImageAssets.shop;
        break;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: DSTheme.of(context).colors.brandPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: padding),
              child: DSText(
                text,
                typography: const DSTextTypography.contentTitle1(),
                color: DSTheme.of(context).colors.textPrimaryAlwaysLight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DSImageAsset(
                asset: imagePath,
                height: 55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum DSCardOrderType { orderAgain, localShop }
