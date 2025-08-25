import '../../entities/product_entity.dart';
import '../../utils/result.dart';

/// Repository interface untuk Product operations
abstract class ProductRepository {
  /// Get all products
  Future<Result<List<ProductEntity>>> getAllProducts();
  
  /// Get available products only
  Future<Result<List<ProductEntity>>> getAvailableProducts();
  
  /// Get product by ID
  Future<Result<ProductEntity>> getProductById(String id);
  
  /// Get products by category
  Future<Result<List<ProductEntity>>> getProductsByCategory(String category);
  
  /// Create new product
  Future<Result<ProductEntity>> createProduct(ProductEntity product);
  
  /// Update existing product
  Future<Result<ProductEntity>> updateProduct(ProductEntity product);
  
  /// Delete product
  Future<Result<void>> deleteProduct(String id);
  
  /// Search products
  Future<Result<List<ProductEntity>>> searchProducts(String query);
  
  /// Get all categories
  Future<Result<List<String>>> getAllCategories();
}