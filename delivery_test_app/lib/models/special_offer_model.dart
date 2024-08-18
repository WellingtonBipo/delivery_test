import 'package:delivery_test/models/product.dart';

class SpecialOfferModel extends Product {
  const SpecialOfferModel({
    required super.id,
    required super.name,
    required String super.imageUrl,
    required this.rate,
    required this.colorHex,
  });

  final double rate;
  final String colorHex;
  @override
  String get imageUrl => super.imageUrl!;

  @override
  bool operator ==(covariant SpecialOfferModel other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.rate == rate &&
        other.colorHex == colorHex;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      rate.hashCode ^
      colorHex.hashCode;
}
