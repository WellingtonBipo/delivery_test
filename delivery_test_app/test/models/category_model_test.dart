// ignore_for_file: prefer_const_constructors

import 'package:delivery_test/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final model1 = CategoryModel(
    id: 1,
    text: 'text',
    imageUrl: 'imageUrl',
  );

  final model2 = CategoryModel(
    id: 1,
    text: 'text',
    imageUrl: 'imageUrl',
  );

  final model3 = CategoryModel(
    id: 2,
    text: 'text',
    imageUrl: 'imageUrl',
  );

  test('When compare equality should compare successfully', () async {
    expect(model1, model2);
    expect(model1.hashCode, model2.hashCode);
    expect(model1, isNot(model3));
    expect(model1.hashCode, isNot(model3.hashCode));
  });
}
