import 'package:collection/collection.dart';
import 'package:delivery_test/models/product.dart';

class ProductDetails extends Product {
  ProductDetails({
    required super.id,
    required this.rate,
    required super.name,
    required this.shop,
    required this.details,
    required this.price,
    required this.oldPrice,
    required this.imagesUrl,
    required this.tags,
  }) : super(imageUrl: imagesUrl.firstOrNull);

  final double rate;
  final String shop;
  final String details;
  final double price;
  final double oldPrice;
  final List<String> imagesUrl;
  final List<ProductTag> tags;

  @override
  bool operator ==(covariant ProductDetails other) {
    if (identical(this, other)) return true;
    return super == other &&
        other.rate == rate &&
        other.shop == shop &&
        other.details == details &&
        other.price == price &&
        other.oldPrice == oldPrice &&
        const ListEquality().equals(other.imagesUrl, imagesUrl) &&
        const ListEquality().equals(other.tags, tags);
  }

  @override
  int get hashCode =>
      super.hashCode ^
      rate.hashCode ^
      shop.hashCode ^
      details.hashCode ^
      price.hashCode ^
      oldPrice.hashCode ^
      const ListEquality().hash(imagesUrl) ^
      const ListEquality().hash(tags);
}

class ProductTag {
  ProductTag({
    required this.text,
    required this.colorHex,
    required this.imageUrl,
  });

  final String text;
  final String colorHex;
  final String imageUrl;

  @override
  bool operator ==(covariant ProductTag other) {
    if (identical(this, other)) return true;
    return other.text == text &&
        other.colorHex == colorHex &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => text.hashCode ^ colorHex.hashCode ^ imageUrl.hashCode;
}
