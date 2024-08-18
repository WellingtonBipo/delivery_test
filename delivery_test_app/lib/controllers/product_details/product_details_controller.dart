import 'dart:convert';

import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/core/utils/controller_state.dart';
import 'package:delivery_test/models/product.dart';
import 'package:delivery_test/models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef ProductDetailsControllerState = ControllerState<ProductDetails, Object>;

class ProductDetailsController extends ChangeNotifier {
  ProductDetailsController(this._backEndConnector);

  static ProductDetailsController read(BuildContext context) => context.read();
  static ProductDetailsController watch(BuildContext context) =>
      context.watch();

  final BackEndConnector _backEndConnector;

  ProductDetailsControllerState _state = const ControllerStateInitial();

  ProductDetailsControllerState get state => _state;

  set _notifyState(ProductDetailsControllerState state) {
    _state = state;
    notifyListeners();
  }

  Product? _product;
  Product? get productToLoad => _product;

  Future<void> loadDetails(Product product) async {
    _product = product;
    _notifyState = const ControllerStateLoading();
    try {
      final result = await _backEndConnector.getProductDetails(product.id);
      _notifyState = result.fold(onSuccess: _deserialize);
    } catch (e) {
      _notifyState = ControllerStateError(e);
    }
  }
}

ProductDetailsControllerState _deserialize(
  BackEndConnectorResponseSuccess response,
) {
  final data = jsonDecode(response.body) as Map;
  return ControllerStateSuccess(
    ProductDetails(
      id: data['id'],
      rate: data['rate'],
      name: data['title'],
      shop: data['shop'],
      details: data['details'],
      price: data['price'],
      oldPrice: data['old_price'],
      imagesUrl: (data['images_url'] as List).cast<String>(),
      tags: (data['tags'] as List).map((e) {
        final tagData = e as Map;
        return ProductTag(
          text: tagData['text'],
          colorHex: tagData['color'],
          imageUrl: tagData['image_url'],
        );
      }).toList(),
    ),
  );
}
