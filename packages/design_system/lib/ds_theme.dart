import 'package:flutter/material.dart';

class DSThemeProvider extends StatelessWidget {
  const DSThemeProvider({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return _DSThemeProvider(builder, MediaQuery.of(context).platformBrightness);
  }
}

class _DSThemeProvider extends InheritedWidget {
  _DSThemeProvider(
    Widget Function(BuildContext context) builder,
    Brightness platformBrightness,
  )   : theme = DSTheme._(platformBrightness),
        super(child: Builder(builder: builder));

  final DSTheme theme;

  @override
  bool updateShouldNotify(covariant _DSThemeProvider oldWidget) {
    return theme.platformBrightness != oldWidget.theme.platformBrightness;
  }
}

class DSTheme {
  DSTheme._(this.platformBrightness)
      : colors = switch (platformBrightness) {
          Brightness.light => DSColors._light(),
          Brightness.dark => DSColors._dark(),
        };

  static DSTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_DSThemeProvider>()!.theme;

  final Brightness platformBrightness;
  final DSColors colors;

  ThemeData get themeData {
    return switch (platformBrightness) {
      Brightness.light => ThemeData(
          brightness: platformBrightness,
          primaryColor: _brandPrimaryLight,
          scaffoldBackgroundColor: _scaffoldLight,
        ),
      Brightness.dark => ThemeData(
          brightness: platformBrightness,
          primaryColor: _brandPrimaryDark,
          scaffoldBackgroundColor: _scaffoldDark,
        ),
    };
  }
}

class DSColors {
  DSColors._light()
      : brandPrimary = _brandPrimaryLight,
        brandSmooth = _brandSmoothLight,
        brandDisable = _brandDisableLight,
        auxiliarBrandPrimary = _auxiliarBrandPrimaryLight,
        scaffoldBackground = _scaffoldLight,
        contentPrimary = _contentPrimaryLight,
        contentSecondary = _contentSecondaryLight,
        textPrimary = _textPrimaryLight,
        textSecondary = _textSecondaryLight,
        textPrimaryAlwaysLight = _textPrimaryLight,
        textSecondaryAlwaysLight = _textSecondaryLight,
        contentPrimaryAlwaysLight = _contentPrimaryLight;

  DSColors._dark()
      : brandPrimary = _brandPrimaryDark,
        brandSmooth = _brandSmoothDark,
        brandDisable = _brandDisableDark,
        auxiliarBrandPrimary = _auxiliarBrandPrimaryDark,
        scaffoldBackground = _scaffoldDark,
        contentPrimary = _contentPrimaryDark,
        contentSecondary = _contentSecondaryDark,
        textPrimary = _textPrimaryDark,
        textSecondary = _textSecondaryDark,
        textPrimaryAlwaysLight = _textPrimaryLight,
        textSecondaryAlwaysLight = _textSecondaryLight,
        contentPrimaryAlwaysLight = _contentPrimaryLight;

  final Color brandPrimary;
  final Color brandSmooth;
  final Color brandDisable;
  final Color auxiliarBrandPrimary;
  final Color scaffoldBackground;
  final Color contentPrimary;
  final Color contentSecondary;
  final Color textPrimary;
  final Color textSecondary;

  final Color textPrimaryAlwaysLight;
  final Color textSecondaryAlwaysLight;
  final Color contentPrimaryAlwaysLight;
}

const _brandPrimaryLight = Color.fromRGBO(84, 226, 159, 1);
const _brandPrimaryDark = Color.fromARGB(255, 71, 195, 138);
const _brandSmoothLight = Color.fromRGBO(191, 239, 202, 1);
const _brandSmoothDark = Color.fromRGBO(117, 171, 130, 1);
const _brandDisableLight = Color.fromRGBO(172, 218, 196, 1);
const _brandDisableDark = Color.fromARGB(255, 145, 185, 166);
const _auxiliarBrandPrimaryLight = Color.fromRGBO(17, 54, 91, 1);
const _auxiliarBrandPrimaryDark = Color.fromARGB(255, 17, 54, 91);
const _scaffoldLight = Color.fromARGB(255, 255, 255, 255);
const _contentPrimaryLight = Color.fromARGB(255, 245, 245, 245);
const _contentPrimaryDark = Color.fromARGB(255, 35, 35, 35);
const _contentSecondaryLight = Color.fromARGB(255, 190, 190, 190);
const _contentSecondaryDark = Color.fromARGB(255, 110, 110, 110);
const _scaffoldDark = Color.fromARGB(255, 25, 25, 25);
const _textPrimaryLight = Color.fromRGBO(14, 50, 87, 1);
const _textPrimaryDark = Color.fromARGB(255, 255, 255, 255);
const _textSecondaryLight = Color.fromARGB(255, 200, 200, 200);
const _textSecondaryDark = Color.fromARGB(255, 150, 150, 150);
