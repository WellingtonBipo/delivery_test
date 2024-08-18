// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:delivery_test/controllers/categories/categories_controller.dart';
import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/core/utils/controller_state.dart';
import 'package:delivery_test/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/controller_test.dart';

class _BackEndConnectorMock extends Mock implements BackEndConnector {}

void main() {
  late BackEndConnector backEndConnector;

  setUp(() => backEndConnector = _BackEndConnectorMock());

  injectionTest(
    'CategoriesController should be injected',
    isAController: isA<CategoriesController>(),
  );

  controllerTest(
    'When getCategories is called,'
    ' and [BackEndConnector] return success response,'
    ' should return a list of categories',
    controller: () => CategoriesController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(backEndConnector.getCategories).thenAnswer(
        (_) async => BackEndConnectorResponseSuccess(
          statusCode: 200,
          body: jsonEncode([
            {'id': 1, 'text': 'text', 'image_url': 'image_url'},
          ]),
        ),
      );
      await controller.getCategories();
    },
    expects: () => [
      isA<ControllerStateLoading>(),
      isA<ControllerStateSuccess>().having((p0) => p0.data, 'data', [
        CategoryModel(id: 1, text: 'text', imageUrl: 'image_url'),
      ]),
    ],
    verify: () => verify(backEndConnector.getCategories).called(1),
  );

  controllerTest(
    'When getCategories is called,'
    ' and [BackEndConnector] return an Error,'
    ' should return an error state',
    controller: () => CategoriesController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(backEndConnector.getCategories).thenAnswer(
        (_) async => BackEndConnectorResponseError(
          statusCode: 200,
          error: 'Error',
        ),
      );
      await controller.getCategories();
    },
    expects: () => [
      isA<ControllerStateLoading>(),
      isA<ControllerStateError>(),
    ],
    verify: () => verify(backEndConnector.getCategories).called(1),
  );

  controllerTest(
    'When getCategories is called,'
    ' and [BackEndConnector] throws an Exception,'
    ' should return an error state',
    controller: () => CategoriesController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(backEndConnector.getCategories).thenThrow(Exception());
      await controller.getCategories();
    },
    expects: () => [
      isA<ControllerStateLoading>(),
      isA<ControllerStateError>(),
    ],
    verify: () => verify(backEndConnector.getCategories).called(1),
  );
}
