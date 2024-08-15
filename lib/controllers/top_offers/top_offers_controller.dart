import 'dart:convert';

import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/models/top_offer_model.dart';

class TopOffersController {
  final _backEndConnector = BackEndConnector();

  Future<List<TopOfferModel>> getTopOffers() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final result = await _backEndConnector.getTopOffers();
    return result.fold(
      onError: (_) => [],
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
        return offers;
      },
    );
  }
}
