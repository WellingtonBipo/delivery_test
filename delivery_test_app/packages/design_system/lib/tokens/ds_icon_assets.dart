import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final class DSIconAssets {
  const DSIconAssets._(this.data);
  final IconData data;

  static const DSIconAssets chevronLeft =
      DSIconAssets._(FontAwesomeIcons.chevronLeft);

  static const DSIconAssets heartEmpty = DSIconAssets._(FontAwesomeIcons.heart);

  static const DSIconAssets heartFilled =
      DSIconAssets._(FontAwesomeIcons.solidHeart);
}
