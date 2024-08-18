// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:delivery_test/controllers/product_details/product_details_controller.dart';
import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/core/utils/controller_state.dart';
import 'package:delivery_test/models/product.dart';
import 'package:delivery_test/models/product_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/controller_test.dart';

class _BackEndConnectorMock extends Mock implements BackEndConnector {}

class _ProductStub extends Product {
  _ProductStub({
    required super.id,
    required super.name,
    required super.imageUrl,
  });
}

void main() {
  final product = _ProductStub(
    id: 'id',
    name: 'name',
    imageUrl: 'imageUrl',
  );

  late BackEndConnector backEndConnector;

  setUp(() => backEndConnector = _BackEndConnectorMock());

  injectionTest(
    'ProductDetailsController should be injected',
    isAController: isA<ProductDetailsController>(),
  );

  test('When call toggleFavorite, should add id in productsFavoritesIds',
      () async {
    when(() => backEndConnector.getProductDetails(product.id)).thenAnswer(
      (_) async => BackEndConnectorResponseError(
        statusCode: 200,
        error: 'Error',
      ),
    );
    final controller = ProductDetailsController(backEndConnector);
    await controller.loadDetails(product);
    expect(controller.productToLoad, product);
  });

  controllerTest(
    'When load is called,'
    ' and [BackEndConnector] return success response,'
    ' should return a ProductDetails',
    controller: () => ProductDetailsController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(() => backEndConnector.getProductDetails(product.id)).thenAnswer(
        (_) async => BackEndConnectorResponseSuccess(
          statusCode: 200,
          body: jsonEncode(
            {
              'id': 'id',
              'rate': 0.0,
              'title': 'name',
              'shop': 'shop',
              'details': 'details',
              'price': 0.0,
              'old_price': 0.0,
              'images_url': ['imagesUrl'],
              'tags': [
                {'text': 'text', 'color': 'color', 'image_url': 'image_url'},
              ],
            },
          ),
        ),
      );
      await controller.loadDetails(product);
    },
    expects: () => [
      isA<ControllerStateLoading>(),
      isA<ControllerStateSuccess>().having(
        (p0) => p0.data,
        'data',
        ProductDetails(
          id: 'id',
          rate: 0,
          name: 'name',
          shop: 'shop',
          details: 'details',
          price: 0,
          oldPrice: 0,
          imagesUrl: ['imagesUrl'],
          tags: [
            ProductTag(
              text: 'text',
              colorHex: 'color',
              imageUrl: 'image_url',
            ),
          ],
        ),
      ),
    ],
    verify: () =>
        verify(() => backEndConnector.getProductDetails(product.id)).called(1),
  );

  controllerTest(
    'When load is called,'
    ' and [BackEndConnector] return an Error,'
    ' should return an error state',
    controller: () => ProductDetailsController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(() => backEndConnector.getProductDetails(product.id)).thenAnswer(
        (_) async => BackEndConnectorResponseError(
          statusCode: 200,
          error: 'Error',
        ),
      );
      await controller.loadDetails(product);
    },
    expects: () => [
      isA<ControllerStateLoading>(),
      isA<ControllerStateError>(),
    ],
    verify: () =>
        verify(() => backEndConnector.getProductDetails(product.id)).called(1),
  );

  controllerTest(
    'When load is called,'
    ' and [BackEndConnector] throws an Exception,'
    ' should return an error state',
    controller: () => ProductDetailsController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(() => backEndConnector.getProductDetails(product.id))
          .thenThrow(Exception());
      await controller.loadDetails(product);
    },
    expects: () => [
      isA<ControllerStateLoading>(),
      isA<ControllerStateError>(),
    ],
    verify: () =>
        verify(() => backEndConnector.getProductDetails(product.id)).called(1),
  );
}
