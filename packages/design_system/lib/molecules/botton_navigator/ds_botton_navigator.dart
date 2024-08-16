import 'dart:math' as math;

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DSBottonNavigator extends StatefulWidget {
  const DSBottonNavigator({
    required this.currentIndex,
    required this.onChange,
    super.key,
  });

  final int currentIndex;
  final void Function(int index) onChange;

  @override
  State<DSBottonNavigator> createState() => _DSBottonNavigatorState();

  static double overflowHeight() =>
      _CustomPainter.padding +
      (_DSBottonNavigatorState.buttonIconSize / 2) -
      _DSBottonNavigatorState.buttonTopPadding;
}

class _DSBottonNavigatorState extends State<DSBottonNavigator> {
  static const double iconSize = 18;
  static const double centralIconPadding = 35;
  static const double buttonIconSize = iconSize + centralIconPadding;
  static const double buttonTopPadding = 5;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          painter: _CustomPainter(
            backgroundColor: DSTheme.of(context).colors.scaffoldBackground,
            shadowColor: switch (DSTheme.of(context).platformBrightness) {
              Brightness.dark => Colors.grey.shade400,
              Brightness.light => Colors.grey.shade100,
            },
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: (MediaQuery.paddingOf(context).bottom - _Item.padding)
                  .clamp(0, double.infinity),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Item(
                  label: 'Home',
                  icon: FontAwesomeIcons.house,
                  isSelected: widget.currentIndex == 0,
                  onTap: () => widget.onChange(0),
                ),
                _Item(
                  label: 'Delas',
                  icon: FontAwesomeIcons.tag,
                  isSelected: widget.currentIndex == 1,
                  onTap: () => widget.onChange(1),
                ),
                const SizedBox(width: buttonIconSize + 20),
                _Item(
                  label: 'Cart',
                  icon: FontAwesomeIcons.bagShopping,
                  isSelected: widget.currentIndex == 3,
                  onTap: () => widget.onChange(3),
                ),
                _Item(
                  label: 'Account',
                  icon: FontAwesomeIcons.solidUser,
                  isSelected: widget.currentIndex == 4,
                  onTap: () => widget.onChange(4),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -(buttonIconSize / 2) + buttonTopPadding,
          left: (MediaQuery.of(context).size.width / 2) - (buttonIconSize / 2),
          child: GestureDetector(
            onTap: () => widget.onChange(2),
            child: Container(
              height: buttonIconSize,
              width: buttonIconSize,
              decoration: BoxDecoration(
                color: DSTheme.of(context).colors.auxiliarBrandPrimary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.shop,
                size: iconSize,
                color: DSTheme.of(context).colors.brandPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final void Function() onTap;

  static const padding = 15.0;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? DSTheme.of(context).colors.brandPrimary
        : DSTheme.of(context).colors.brandDisable;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: _DSBottonNavigatorState.iconSize,
              color: color,
            ),
            const SizedBox(height: 6),
            DSText(
              label,
              typography: const DSTextTypography.content(),
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomPainter extends CustomPainter {
  const _CustomPainter({
    required this.backgroundColor,
    required this.shadowColor,
  });

  final Color backgroundColor;
  final Color shadowColor;

  static const padding = 10.0;
  static double get radius =>
      (_DSBottonNavigatorState.buttonIconSize / 2) + padding;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  void paint(Canvas canvas, Size size) {
    final sideCurveWidth = radius * 0.3;
    final shiftedRadius = _calculateParallelDiameterLine(
          radius,
          _DSBottonNavigatorState.buttonTopPadding,
        ) /
        2;
    final shiftedRadiusSideCurve = shiftedRadius - (sideCurveWidth * 0.4);
    final middle = size.width / 2;
    final aPoint = Offset(middle - (shiftedRadius + sideCurveWidth), 0);
    final bPoint =
        Offset(middle, -(radius - _DSBottonNavigatorState.buttonTopPadding));
    final cPoint = Offset(middle + (shiftedRadius + sideCurveWidth), aPoint.dy);
    final ab1Control = Offset(middle - shiftedRadiusSideCurve, 0);
    final ab2Control = Offset(ab1Control.dx, bPoint.dy);
    final bc1Control = Offset(middle + shiftedRadiusSideCurve, bPoint.dy);
    final bc2Control = Offset(bc1Control.dx, 0);

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(aPoint.dx, aPoint.dy)
      ..cubicTo(
        ab1Control.dx,
        ab1Control.dy,
        ab2Control.dx,
        ab2Control.dy,
        bPoint.dx,
        bPoint.dy,
      )
      ..cubicTo(
        bc1Control.dx,
        bc1Control.dy,
        bc2Control.dx,
        bc2Control.dy,
        cPoint.dx,
        cPoint.dy,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas
      ..drawShadow(path.shift(const Offset(0, -10)), shadowColor, 15, true)
      ..drawPath(path, Paint()..color = backgroundColor);
  }
}

double _calculateParallelDiameterLine(double radius, double centerDistance) {
  final parallelRadius =
      math.sqrt(math.pow(radius, 2) - math.pow(centerDistance, 2));
  return parallelRadius * 2;
}
