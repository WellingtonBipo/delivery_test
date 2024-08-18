import 'dart:async';
import 'dart:io';

import 'package:delivery_test/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

@isTest
void controllerTest<C extends ChangeNotifier, T>(
  String description, {
  required C Function() controller,
  required T Function(C controller) listenController,
  required FutureOr<void> Function(C controller) act,
  required List Function() expects,
  void Function()? verify,
}) =>
    test(description, () async {
      final contr = controller();
      final results = <T>[];
      void _listen() => results.add(listenController(contr));
      contr.addListener(_listen);
      await act(contr);
      expect(results, orderedEquals(expects()));
      verify?.call();
      contr.removeListener(_listen);
    });

@isTest
void injectionTest<C extends ChangeNotifier>(
  String description, {
  required TypeMatcher<C> isAController,
}) {
  HttpOverrides.global = _HttpOverrides();
  testWidgets(description, (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    final materialAppFinder = find.byType(MaterialApp);
    final materialApp = tester.state(materialAppFinder);
    // ignore: use_build_context_synchronously
    final controller = Provider.of<C>(materialApp.context, listen: false);
    expect(controller, isAController);
  });
}

class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _HttpClient();
}

class _HttpClient extends Mock implements HttpClient {}
