import 'package:design_system/ds_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DSText extends StatelessWidget {
  const DSText(
    this.text, {
    this.typography,
    this.color,
    super.key,
  });
  final String text;
  final Color? color;
  final DSTextTypography? typography;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: (typography ?? DSTextTypography.body())
          ._toStyle(color ?? DSTheme.of(context).colors.textPrimary),
    );
  }
}

class DSTextTypography {
  DSTextTypography.small()
      : _fontSize = 12,
        _fontWeight = FontWeight.normal;

  DSTextTypography.smallSemiBold()
      : _fontSize = 12,
        _fontWeight = FontWeight.w600;

  DSTextTypography.body()
      : _fontSize = 14,
        _fontWeight = FontWeight.normal;

  final double _fontSize;
  final FontWeight _fontWeight;

  TextStyle _toStyle(Color color) {
    return GoogleFonts.getFont(
      'Nunito',
      color: color,
      fontSize: _fontSize,
      fontWeight: _fontWeight,
    );
  }
}
