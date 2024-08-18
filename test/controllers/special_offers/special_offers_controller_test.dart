// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:delivery_test/controllers/special_offers/special_offers_controller.dart';
import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/core/utils/controller_state.dart';
import 'package:delivery_test/models/special_offer_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/controller_test.dart';

class _BackEndConnectorMock extends Mock implements BackEndConnector {}

void main() {
  late BackEndConnector backEndConnector;

  setUp(() => backEndConnector = _BackEndConnectorMock());

  injectionTest(
    'SpecialOffersController should be injected',
    isAController: isA<SpecialOffersController>(),
  );

  test('When call toggleFavorite, should add id in productsFavoritesIds', () {
    final controller = SpecialOffersController(backEndConnector)
      ..toggleFavorite('id');
    expect(controller.productsFavoritesIds, contains('id'));
    controller.toggleFavorite('id');
    expect(controller.productsFavoritesIds, isNot(contains('id')));
  });

  controllerTest(
    'When getOffers is called,'
    ' and [BackEndConnector] return success response,'
    ' should return a ProductDetails',
    controller: () => SpecialOffersController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(() => backEndConnector.getSpecialOffers()).thenAnswer(
        (_) async => BackEndConnectorResponseSuccess(
          statusCode: 200,
          body: jsonEncode(
            [
              {
                'id': 'id',
                'text': 'name',
                'rate': 0.0,
                'color_hex': 'colorHex',
                'image_url': 'imageUrl',
              },
            ],
          ),
        ),
      );
      await controller.getOffers();
    },
    expects: () => [
      isA<ControllerStateLoading>(),
      isA<ControllerStateSuccess>().having((p0) => p0.data, 'data', [
        SpecialOfferModel(
          id: 'id',
          rate: 0,
          name: 'name',
          colorHex: 'colorHex',
          imageUrl: 'imageUrl',
        ),
      ]),
    ],
    verify: () => verify(backEndConnector.getSpecialOffers).called(1),
  );

  controllerTest(
    'When getOffers is called,'
    ' and [BackEndConnector] return an Error,'
    ' should return an error state',
    controller: () => SpecialOffersController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(backEndConnector.getSpecialOffers).thenAnswer(
        (_) async => BackEndConnectorResponseError(
          statusCode: 200,
          error: 'Error',
        ),
      );
      await controller.getOffers();
    },
    expects: () => [
      isA<ControllerStateLoading>(),
      isA<ControllerStateError>(),
    ],
    verify: () => verify(backEndConnector.getSpecialOffers).called(1),
  );

  controllerTest(
    'When getOffers is called,'
    ' and [BackEndConnector] throws an Exception,'
    ' should return an error state',
    controller: () => SpecialOffersController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(backEndConnector.getSpecialOffers).thenThrow(Exception());
      await controller.getOffers();
    },
    expects: () => [
      isA<ControllerStateLoading>(),
      isA<ControllerStateError>(),
    ],
    verify: () => verify(backEndConnector.getSpecialOffers).called(1),
  );
}
