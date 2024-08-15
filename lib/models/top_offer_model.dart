class TopOfferModel {
  const TopOfferModel({
    required this.title,
    required this.imageUrl,
    required this.buttonText,
    required this.colorHex,
    this.header,
  });

  final String? header;
  final String title;
  final String imageUrl;
  final String buttonText;
  final String colorHex;
}
