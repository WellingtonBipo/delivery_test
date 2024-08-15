import 'dart:convert';

import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/models/special_offer_model.dart';

class SpecialOffersController {
  final _backEndConnector = BackEndConnector();

  Future<List<SpecialOfferModel>> getSpecialOffers() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final result = await _backEndConnector.getSpecialOffers();
    return result.fold(
      onError: (_) => [],
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
        return offers;
      },
    );
  }
}
