// ignore_for_file: prefer_const_constructors

import 'package:delivery_test/models/top_offer_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final model1 = TopOfferModel(
    title: 'title',
    imageUrl: 'imageUrl',
    buttonText: 'buttonText',
    colorHex: 'colorHex',
  );

  final model2 = TopOfferModel(
    title: 'title',
    imageUrl: 'imageUrl',
    buttonText: 'buttonText',
    colorHex: 'colorHex',
  );

  final model3 = TopOfferModel(
    title: 'title2',
    imageUrl: 'imageUrl',
    buttonText: 'buttonText',
    colorHex: 'colorHex',
  );

  test('When compare equality should compare successfully', () async {
    expect(model1, model2);
    expect(model1.hashCode, model2.hashCode);
    expect(model1, isNot(model3));
    expect(model1.hashCode, isNot(model3.hashCode));
  });
}
