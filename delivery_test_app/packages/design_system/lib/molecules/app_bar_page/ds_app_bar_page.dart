import 'package:design_system/ds_theme.dart';
import 'package:design_system/tokens/ds_icon_assets.dart';
import 'package:flutter/material.dart';

class DSAppBarPage extends StatelessWidget implements PreferredSizeWidget {
  const DSAppBarPage({
    this.rightIcon,
    super.key,
  });

  final DSAppBarIconButton? rightIcon;

  @override
  Size get preferredSize => const Size(double.infinity, 40);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DSAppBarIconButton(
                icon: DSIconAssets.chevronLeft,
                onTap: () => Navigator.of(context).maybePop(),
              ),
              if (rightIcon != null) rightIcon!,
            ],
          ),
        ],
      ),
    );
  }
}

final class DSAppBarIconButton extends StatelessWidget {
  const DSAppBarIconButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  final DSIconAssets icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: DSTheme.of(context).colors.contentPrimary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon.data,
          size: 20,
          color: DSTheme.of(context).colors.textPrimary,
        ),
      ),
    );
  }
}
