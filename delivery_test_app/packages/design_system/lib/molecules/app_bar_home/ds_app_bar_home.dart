import 'package:design_system/atoms/image_asset/ds_image_asset.dart';
import 'package:design_system/atoms/text/ds_text.dart';
import 'package:design_system/ds_theme.dart';
import 'package:design_system/tokens/ds_image_assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DSAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const DSAppBarHome({
    required this.title,
    required this.location,
    required this.onTapLocation,
    required this.onTapProfile,
    super.key,
  });

  final String title;
  final String location;
  final void Function() onTapLocation;
  final void Function() onTapProfile;

  static const height = 60.0;

  @override
  Size get preferredSize => const Size(double.infinity, height);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTapLocation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DSText(
                    title,
                    typography: const DSTextTypography.header4(),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      DSText(
                        location,
                        typography: const DSTextTypography.header5(),
                        color: DSTheme.of(context).colors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        FontAwesomeIcons.chevronDown,
                        size: 12,
                        color: DSTheme.of(context).colors.textPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTapProfile,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: DSTheme.of(context).colors.brandSmooth,
              child: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: DSImageAsset(
                  asset: DSImageAssets.thumbsUp,
                  height: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
