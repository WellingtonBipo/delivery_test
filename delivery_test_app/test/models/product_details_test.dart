// ignore_for_file: prefer_const_constructors

import 'package:delivery_test/models/product_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final modelTag1 = ProductTag(
    text: 'text',
    colorHex: 'colorHex',
    imageUrl: 'imageUrl',
  );

  final modelTag2 = ProductTag(
    text: 'text',
    colorHex: 'colorHex',
    imageUrl: 'imageUrl',
  );

  final modelTag3 = ProductTag(
    text: 'text2',
    colorHex: 'colorHex',
    imageUrl: 'imageUrl',
  );

  final model1 = ProductDetails(
    id: '1',
    rate: 1,
    details: 'details',
    imagesUrl: ['imageUrl'],
    name: 'name',
    price: 1,
    shop: 'shop',
    oldPrice: 1,
    tags: [modelTag1, modelTag2],
  );

  final model2 = ProductDetails(
    id: '1',
    rate: 1,
    details: 'details',
    imagesUrl: ['imageUrl'],
    name: 'name',
    price: 1,
    shop: 'shop',
    oldPrice: 1,
    tags: [modelTag1, modelTag2],
  );

  final model3 = ProductDetails(
    id: '2',
    rate: 1,
    details: 'details',
    imagesUrl: ['imageUrl'],
    name: 'name',
    price: 1,
    shop: 'shop',
    oldPrice: 1,
    tags: [modelTag1, modelTag3],
  );

  test('When compare equality should compare successfully', () async {
    expect(model1, model2);
    expect(model1.hashCode, model2.hashCode);
    expect(model1, isNot(model3));
    expect(model1.hashCode, isNot(model3.hashCode));
  });
}
