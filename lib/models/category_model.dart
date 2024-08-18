class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.text,
    required this.imageUrl,
  });

  final int id;
  final String text;
  final String imageUrl;

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;
    return other.id == id && other.text == text && other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ imageUrl.hashCode;
}
