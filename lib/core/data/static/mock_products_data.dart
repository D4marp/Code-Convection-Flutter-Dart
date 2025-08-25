import '../../entities/product_entity.dart';

/// Static mock data untuk products
class MockProductsData {
  static const List<Map<String, dynamic>> _productsJson = [
    {
      'id': 'prod_001',
      'name': 'Smartphone Premium',
      'description': 'High-end smartphone with advanced features',
      'price': 999.99,
      'category': 'Electronics',
      'images': [
        'https://example.com/images/phone1.jpg',
        'https://example.com/images/phone2.jpg',
      ],
      'is_available': true,
      'created_at': '2024-01-10T08:00:00Z',
      'updated_at': '2024-01-15T10:30:00Z',
      'specifications': {
        'brand': 'TechBrand',
        'model': 'Premium X1',
        'storage': '256GB',
        'ram': '8GB',
        'color': 'Space Gray',
      },
    },
    {
      'id': 'prod_002',
      'name': 'Wireless Headphones',
      'description': 'Premium noise-cancelling wireless headphones',
      'price': 299.99,
      'category': 'Audio',
      'images': [
        'https://example.com/images/headphones1.jpg',
      ],
      'is_available': true,
      'created_at': '2024-01-12T12:00:00Z',
      'updated_at': '2024-01-18T16:45:00Z',
      'specifications': {
        'brand': 'AudioTech',
        'model': 'Silence Pro',
        'battery_life': '30 hours',
        'connectivity': 'Bluetooth 5.0',
        'color': 'Black',
      },
    },
    {
      'id': 'prod_003',
      'name': 'Gaming Laptop',
      'description': 'High-performance gaming laptop for professionals',
      'price': 1599.99,
      'category': 'Computers',
      'images': [
        'https://example.com/images/laptop1.jpg',
        'https://example.com/images/laptop2.jpg',
        'https://example.com/images/laptop3.jpg',
      ],
      'is_available': false,
      'created_at': '2024-01-05T14:30:00Z',
      'updated_at': '2024-01-20T09:15:00Z',
      'specifications': {
        'brand': 'GameTech',
        'model': 'Pro Gamer 15',
        'processor': 'Intel i7-12700H',
        'graphics': 'RTX 3070',
        'ram': '16GB',
        'storage': '1TB SSD',
      },
    },
  ];

  /// Get all mock products as entities
  static List<ProductEntity> getAllProducts() {
    return _productsJson.map((json) => _mapToEntity(json)).toList();
  }

  /// Get available products only
  static List<ProductEntity> getAvailableProducts() {
    return _productsJson
        .where((product) => product['is_available'] as bool)
        .map((json) => _mapToEntity(json))
        .toList();
  }

  /// Get products by category
  static List<ProductEntity> getProductsByCategory(String category) {
    return _productsJson
        .where((product) => product['category'] == category)
        .map((json) => _mapToEntity(json))
        .toList();
  }

  /// Get product by ID
  static ProductEntity? getProductById(String id) {
    try {
      final json = _productsJson.firstWhere((product) => product['id'] == id);
      return _mapToEntity(json);
    } catch (e) {
      return null;
    }
  }

  /// Get all categories
  static List<String> getAllCategories() {
    return _productsJson
        .map((product) => product['category'] as String)
        .toSet()
        .toList();
  }

  /// Map JSON to ProductEntity
  static ProductEntity _mapToEntity(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      images: List<String>.from(json['images'] as List),
      isAvailable: json['is_available'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      specifications: Map<String, dynamic>.from(
        json['specifications'] as Map<String, dynamic>,
      ),
    );
  }

  /// Get raw JSON data for testing
  static List<Map<String, dynamic>> getRawData() {
    return List.from(_productsJson);
  }
}