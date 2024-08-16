import 'dart:convert';

import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/core/utils/controller_state.dart';
import 'package:delivery_test/models/special_offer_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef SpecialOffersControllerState
    = ControllerState<List<SpecialOfferModel>, Object>;

class SpecialOffersController extends ChangeNotifier {
  SpecialOffersController({required BackEndConnector backEndConnector})
      : _backEndConnector = backEndConnector;

  static SpecialOffersController read(BuildContext context) => context.read();
  static SpecialOffersController watch(BuildContext context) => context.watch();

  final BackEndConnector _backEndConnector;

  SpecialOffersControllerState _state = const ControllerStateInitial();

  SpecialOffersControllerState get state => _state;

  set _notifyState(SpecialOffersControllerState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getOffers() async {
    _notifyState = const ControllerStateLoading();
    try {
      final result = await _backEndConnector.getSpecialOffers();

      _notifyState = result.fold(
        onError: (e) => throw e,
        onSuccess: (response) {
          final offers = <SpecialOfferModel>[];
          final offersJson = jsonDecode(response.body) as List;
          for (final Map offerJson in offersJson) {
            offers.add(
              SpecialOfferModel(
                id: offerJson['id'],
                text: offerJson['text'],
                rate: offerJson['rate'],
                colorHex: offerJson['color_hex'],
                imageUrl: offerJson['image_url'],
              ),
            );
          }
          return ControllerStateSuccess(
            offers,
            transformData: (e) => e.toList(),
          );
        },
      );
    } catch (e) {
      print(e);
      _notifyState = ControllerStateError(e);
    }
  }
}
