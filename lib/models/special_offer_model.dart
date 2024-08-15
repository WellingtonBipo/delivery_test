class SpecialOfferModel {
  const SpecialOfferModel({
    required this.id,
    required this.text,
    required this.rate,
    required this.colorHex,
    required this.imageUrl,
  });

  final String id;
  final String text;
  final double rate;
  final String colorHex;
  final String imageUrl;
}
