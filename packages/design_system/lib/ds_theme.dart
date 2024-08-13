import 'package:flutter/material.dart';

class DSThemeProvider extends StatelessWidget {
  const DSThemeProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _DSThemeProvider(child, MediaQuery.of(context).platformBrightness);
  }
}

class _DSThemeProvider extends InheritedWidget {
  _DSThemeProvider(
    Widget child,
    Brightness platformBrightness,
  )   : theme = DSTheme._(platformBrightness),
        super(child: child);

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

  final Brightness platformBrightness;
  final DSColors colors;

  static DSTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_DSThemeProvider>()!.theme;
}

class DSColors {
  DSColors._light()
      : brandPrimary = const Color.fromRGBO(84, 226, 159, 1),
        brandSecondary = const Color.fromRGBO(172, 218, 196, 1),
        auxiliarBrandPrimary = const Color.fromRGBO(17, 54, 91, 1),
        scaffoldBackground = const Color.fromARGB(255, 255, 255, 255),
        contentPrimary = Colors.green,
        contentSecondary = Colors.green,
        textPrimary = Colors.black,
        contentBackgroundSecondary = Colors.green;

  DSColors._dark()
      : brandPrimary = const Color.fromARGB(255, 71, 195, 138),
        brandSecondary = const Color.fromARGB(255, 145, 185, 166),
        auxiliarBrandPrimary = const Color.fromRGBO(17, 54, 91, 1),
        scaffoldBackground = const Color.fromARGB(255, 25, 25, 25),
        contentPrimary = Colors.green,
        contentSecondary = Colors.green,
        textPrimary = Colors.white,
        contentBackgroundSecondary = Colors.green;

  final Color brandPrimary;
  final Color brandSecondary;
  final Color auxiliarBrandPrimary;
  final Color scaffoldBackground;
  final Color contentPrimary;
  final Color contentSecondary;
  final Color textPrimary;
  final Color contentBackgroundSecondary;
}
