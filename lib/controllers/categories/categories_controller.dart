import 'dart:convert';

import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/core/utils/controller_state.dart';
import 'package:delivery_test/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef CategoriesControllerState
    = ControllerState<List<CategoryModel>, Object>;

class CategoriesController extends ChangeNotifier {
  CategoriesController(this._backEndConnector);

  static CategoriesController read(BuildContext context) => context.read();
  static CategoriesController watch(BuildContext context) => context.watch();

  final BackEndConnector _backEndConnector;

  CategoriesControllerState _state = const ControllerStateInitial();

  CategoriesControllerState get state => _state;

  set _notifyState(CategoriesControllerState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getCategories() async {
    _notifyState = const ControllerStateLoading();
    try {
      final result = await _backEndConnector.getCategories();
      _notifyState = result.fold(onSuccess: _deserialize);
    } catch (e) {
      _notifyState = ControllerStateError(e);
    }
  }
}

CategoriesControllerState _deserialize(
  BackEndConnectorResponseSuccess response,
) {
  final offers = <CategoryModel>[];
  final offersJson = jsonDecode(response.body) as List;
  for (final Map offerJson in offersJson) {
    offers.add(
      CategoryModel(
        id: offerJson['id'],
        text: offerJson['text'],
        imageUrl: offerJson['image_url'],
      ),
    );
  }
  return ControllerStateSuccess(
    offers,
    transformData: (e) => e.toList(),
  );
}
