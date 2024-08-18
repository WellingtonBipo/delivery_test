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

  @override
  bool operator ==(covariant TopOfferModel other) {
    if (identical(this, other)) return true;

    return other.header == header &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.buttonText == buttonText &&
        other.colorHex == colorHex;
  }

  @override
  int get hashCode {
    return header.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        buttonText.hashCode ^
        colorHex.hashCode;
  }
}
