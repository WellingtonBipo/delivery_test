// ignore_for_file: prefer_const_constructors

import 'package:delivery_test/models/special_offer_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final model1 = SpecialOfferModel(
    id: '1',
    name: 'name',
    imageUrl: 'imageUrl',
    rate: 1,
    colorHex: 'colorHex',
  );

  final model2 = SpecialOfferModel(
    id: '1',
    name: 'name',
    imageUrl: 'imageUrl',
    rate: 1,
    colorHex: 'colorHex',
  );

  final model3 = SpecialOfferModel(
    id: '2',
    name: 'name',
    imageUrl: 'imageUrl',
    rate: 1,
    colorHex: 'colorHex',
  );

  test('When compare equality should compare successfully', () async {
    expect(model1, model2);
    expect(model1.hashCode, model2.hashCode);
    expect(model1, isNot(model3));
    expect(model1.hashCode, isNot(model3.hashCode));
  });
}
