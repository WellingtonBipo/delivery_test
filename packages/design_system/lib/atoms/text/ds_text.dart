import 'package:design_system/atoms/shimmer/ds_shimmer.dart';
import 'package:design_system/ds_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DSText extends StatelessWidget {
  const DSText(
    this.text, {
    this.typography,
    this.color,
    this.overflow,
    this.softWrap,
    this.textAlign,
    this.decoration,
    this.isLoading = false,
    super.key,
  });

  final String text;
  final Color? color;
  final DSTextTypography? typography;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextAlign? textAlign;
  final bool isLoading;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? DSTheme.of(context).colors.textPrimary;
    final typography = this.typography ?? const DSTextTypography.body();
    if (isLoading) {
      final size = typography.textWidgetSize(context, text: text);
      return DSShimmer(
        enabled: isLoading,
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );
    }
    return Text(
      text,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
      style: typography.toTextStyle(color: color, decoration: decoration),
    );
  }
}

class DSTextTypography {
  const DSTextTypography.content()
      : _fontSize = 12,
        _fontWeight = FontWeight.w600;

  const DSTextTypography.body()
      : _fontSize = 14,
        _fontWeight = FontWeight.normal;

  const DSTextTypography.bodyBold()
      : _fontSize = 14,
        _fontWeight = FontWeight.bold;

  const DSTextTypography.header1()
      : _fontSize = 26,
        _fontWeight = FontWeight.w900;

  const DSTextTypography.header2()
      : _fontSize = 22,
        _fontWeight = FontWeight.w900;

  const DSTextTypography.header3()
      : _fontSize = 18,
        _fontWeight = FontWeight.w900;

  const DSTextTypography.header4()
      : _fontSize = 16,
        _fontWeight = FontWeight.bold;

  const DSTextTypography.header5()
      : _fontSize = 14,
        _fontWeight = FontWeight.bold;

  const DSTextTypography.contentTitle1()
      : _fontSize = 16,
        _fontWeight = FontWeight.w900;

  const DSTextTypography.contentTitle2()
      : _fontSize = 14,
        _fontWeight = FontWeight.w900;

  final double _fontSize;
  final FontWeight _fontWeight;

  TextStyle toTextStyle({Color? color, TextDecoration? decoration}) {
    return GoogleFonts.getFont(
      'Nunito',
      color: color,
      fontSize: _fontSize,
      fontWeight: _fontWeight,
      decoration: decoration,
    );
  }

  Size textWidgetSize(
    BuildContext context, {
    String text = '',
    double maxWidth = double.infinity,
    TextScaler? textScaler,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: toTextStyle()),
      textDirection: Directionality.of(context),
      textScaler: textScaler ?? MediaQuery.textScalerOf(context),
    )..layout(maxWidth: maxWidth);
    return Size(textPainter.size.width + 1, textPainter.size.height + 1);
  }
}
