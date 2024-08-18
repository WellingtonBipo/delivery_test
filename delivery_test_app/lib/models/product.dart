abstract class Product {
  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String? imageUrl;
}
