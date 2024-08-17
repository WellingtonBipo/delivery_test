import 'dart:convert';

import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/core/utils/controller_state.dart';
import 'package:delivery_test/models/top_offer_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef TopOffersControllerState = ControllerState<List<TopOfferModel>, Object>;

class TopOffersController extends ChangeNotifier {
  TopOffersController(this._backEndConnector);

  static TopOffersController read(BuildContext context) => context.read();
  static TopOffersController watch(BuildContext context) => context.watch();

  final BackEndConnector _backEndConnector;

  TopOffersControllerState _state = const ControllerStateInitial();

  TopOffersControllerState get state => _state;

  set _notifyState(TopOffersControllerState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getOffers() async {
    _notifyState = const ControllerStateLoading();
    try {
      final result = await _backEndConnector.getTopOffers();
      _notifyState = result.fold(
        onError: (e) => throw e,
        onSuccess: (response) {
          final offers = <TopOfferModel>[];
          final offersJson = jsonDecode(response.body) as List;
          for (final Map offerJson in offersJson) {
            offers.add(
              TopOfferModel(
                title: offerJson['title'],
                imageUrl: offerJson['image_url'],
                buttonText: offerJson['button_text'],
                header: offerJson['header'],
                colorHex: offerJson['color_hex'],
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
