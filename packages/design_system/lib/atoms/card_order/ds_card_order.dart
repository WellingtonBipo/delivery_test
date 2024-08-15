import 'package:design_system/atoms/text/ds_text.dart';
import 'package:design_system/ds_theme.dart';
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
    switch (type) {
      case DSCardOrderType.orderAgain:
        text = 'ORDER\nAGAIN';
        break;
      case DSCardOrderType.localShop:
        text = 'LOCAL\nSHOP';
        break;
    }
    return Container(
      padding: const EdgeInsets.only(
        left: padding,
        top: padding,
        bottom: padding,
      ),
      decoration: BoxDecoration(
        color: DSTheme.of(context).colors.brandPrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DSText(
        text,
        typography: DSTextTypography.contentTitle2(),
        color: DSTheme.of(context).colors.textPrimaryAlwaysLight,
      ),
    );
  }
}

enum DSCardOrderType { orderAgain, localShop }
