class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  final int price;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.price,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['image_url'] ?? '',
      category: map['category'] ?? '',
      price: map['price']?.toInt() ?? 0,
    );
  }
}
