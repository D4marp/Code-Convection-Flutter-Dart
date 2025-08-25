import '../../entities/user_entity.dart';
import '../../utils/result.dart';

/// Repository interface untuk User operations
/// Mengikuti Dependency Inversion Principle
abstract class UserRepository {
  /// Get all users
  Future<Result<List<UserEntity>>> getAllUsers();
  
  /// Get user by ID
  Future<Result<UserEntity>> getUserById(String id);
  
  /// Create new user
  Future<Result<UserEntity>> createUser(UserEntity user);
  
  /// Update existing user
  Future<Result<UserEntity>> updateUser(UserEntity user);
  
  /// Delete user
  Future<Result<void>> deleteUser(String id);
  
  /// Get users by role
  Future<Result<List<UserEntity>>> getUsersByRole(String role);
  
  /// Search users by name or email
  Future<Result<List<UserEntity>>> searchUsers(String query);
}