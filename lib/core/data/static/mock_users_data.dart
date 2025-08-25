import '../../entities/user_entity.dart';

/// Static mock data untuk testing dan development
class MockUsersData {
  static const List<Map<String, dynamic>> _usersJson = [
    {
      'id': 'user_001',
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'profile_image': 'https://example.com/images/john.jpg',
      'created_at': '2024-01-15T10:30:00Z',
      'is_active': true,
      'roles': ['user', 'premium'],
    },
    {
      'id': 'user_002',
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'profile_image': null,
      'created_at': '2024-01-20T14:45:00Z',
      'is_active': true,
      'roles': ['user'],
    },
    {
      'id': 'user_003',
      'name': 'Admin User',
      'email': 'admin@example.com',
      'profile_image': 'https://example.com/images/admin.jpg',
      'created_at': '2024-01-01T00:00:00Z',
      'is_active': true,
      'roles': ['admin', 'user'],
    },
  ];

  /// Get all mock users as entities
  static List<UserEntity> getAllUsers() {
    return _usersJson.map((json) => _mapToEntity(json)).toList();
  }

  /// Get user by ID
  static UserEntity? getUserById(String id) {
    try {
      final json = _usersJson.firstWhere((user) => user['id'] == id);
      return _mapToEntity(json);
    } catch (e) {
      return null;
    }
  }

  /// Get users by role
  static List<UserEntity> getUsersByRole(String role) {
    return _usersJson
        .where((user) => (user['roles'] as List).contains(role))
        .map((json) => _mapToEntity(json))
        .toList();
  }

  /// Map JSON to UserEntity
  static UserEntity _mapToEntity(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: json['profile_image'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      isActive: json['is_active'] as bool,
      roles: List<String>.from(json['roles'] as List),
    );
  }

  /// Get raw JSON data for testing
  static List<Map<String, dynamic>> getRawData() {
    return List.from(_usersJson);
  }
}