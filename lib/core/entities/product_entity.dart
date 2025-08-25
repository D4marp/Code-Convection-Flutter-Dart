/// Domain entity untuk Product
class ProductEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> images;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> specifications;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.images = const [],
    this.isAvailable = true,
    required this.createdAt,
    required this.updatedAt,
    this.specifications = const {},
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductEntity &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.category == category &&
        other.isAvailable == isAvailable;
  }

  @override
  int get hashCode {
    return Object.hash(id, name, price, category, isAvailable);
  }

  @override
  String toString() {
    return 'ProductEntity(id: $id, name: $name, price: $price)';
  }
}