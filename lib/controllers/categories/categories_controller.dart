import 'dart:convert';

import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:delivery_test/models/category_model.dart';

class CategoriesController {
  final _backEndConnector = BackEndConnector();

  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final result = await _backEndConnector.getCategories();
    return result.fold(
      onError: (_) => [],
      onSuccess: (response) {
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
        return offers;
      },
    );
  }
}
