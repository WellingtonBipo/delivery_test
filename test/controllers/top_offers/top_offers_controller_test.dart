// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:delivery_test/controllers/top_offers/top_offers_controller.dart';
import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/core/utils/controller_state.dart';
import 'package:delivery_test/models/top_offer_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/controller_test.dart';

class _BackEndConnectorMock extends Mock implements BackEndConnector {}

void main() {
  late BackEndConnector backEndConnector;

  setUp(() => backEndConnector = _BackEndConnectorMock());

  injectionTest(
    'TopOffersController should be injected',
    isAController: isA<TopOffersController>(),
  );

  controllerTest(
    'When getOffers is called,'
    ' and [BackEndConnector] return success response,'
    ' should return a ProductDetails',
    controller: () => TopOffersController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(() => backEndConnector.getTopOffers()).thenAnswer(
        (_) async => BackEndConnectorResponseSuccess(
          statusCode: 200,
          body: jsonEncode(
            [
              {
                'title': 'title',
                'header': 'header',
                'button_text': 'buttonText',
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
        TopOfferModel(
          title: 'title',
          buttonText: 'buttonText',
          header: 'header',
          colorHex: 'colorHex',
          imageUrl: 'imageUrl',
        ),
      ]),
    ],
    verify: () => verify(backEndConnector.getTopOffers).called(1),
  );

  controllerTest(
    'When getOffers is called,'
    ' and [BackEndConnector] return an Error,'
    ' should return an error state',
    controller: () => TopOffersController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(backEndConnector.getTopOffers).thenAnswer(
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
    verify: () => verify(backEndConnector.getTopOffers).called(1),
  );

  controllerTest(
    'When getOffers is called,'
    ' and [BackEndConnector] throws an Exception,'
    ' should return an error state',
    controller: () => TopOffersController(backEndConnector),
    listenController: (controller) => controller.state,
    act: (controller) async {
      when(backEndConnector.getTopOffers).thenThrow(Exception());
      await controller.getOffers();
    },
    expects: () => [
      isA<ControllerStateLoading>(),
      isA<ControllerStateError>(),
    ],
    verify: () => verify(backEndConnector.getTopOffers).called(1),
  );
}
