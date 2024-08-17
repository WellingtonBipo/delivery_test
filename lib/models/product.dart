abstract class Product {
  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String? imageUrl;

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
    return other.id == id && other.name == name && other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ imageUrl.hashCode;
}
