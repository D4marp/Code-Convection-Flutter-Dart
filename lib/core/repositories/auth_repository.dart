import '../models/user_model.dart';
import '../services/api_service.dart';
import '../data/static/mock_users_data.dart';

/// Repository untuk menangani autentikasi
class AuthRepository {
  final ApiService _apiService;
  
  // Flag untuk menggunakan mock data (set true untuk testing)
  static const bool _useMockData = true;

  const AuthRepository(this._apiService);

  /// Login user dengan dummy data
  Future<UserModel> login(String email, String password) async {
    if (_useMockData) {
      // Simulasi delay network
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Data login dummy yang valid
      final validCredentials = {
        'john.doe@example.com': 'password123',
        'jane.smith@example.com': 'password123',
        'admin@example.com': 'admin123',
      };
      
      if (validCredentials[email] == password) {
        // Cari user berdasarkan email
        final users = MockUsersData.getAllUsers();
        final user = users.firstWhere(
          (u) => u.email == email,
          orElse: () => throw AuthException('User not found'),
        );
        
        return UserModel(
          id: user.id,
          name: user.name,
          email: user.email,
          profileImage: user.profileImage,
          createdAt: user.createdAt,
        );
      } else {
        throw AuthException('Invalid email or password');
      }
    }
    
    // Kode asli untuk API call
    try {
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      return UserModel.fromJson(response['user'] as Map<String, dynamic>);
    } catch (e) {
      throw AuthException('Login failed: $e');
    }
  }

  /// Register user baru dengan dummy data
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (_useMockData) {
      // Simulasi delay network
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Simulasi registrasi berhasil
      return UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        profileImage: null,
        createdAt: DateTime.now(),
      );
    }
    
    // Kode asli untuk API call
    try {
      final response = await _apiService.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      return UserModel.fromJson(response['user'] as Map<String, dynamic>);
    } catch (e) {
      throw AuthException('Registration failed: $e');
    }
  }

  /// Logout user
  Future<void> logout() async {
    if (_useMockData) {
      // Simulasi delay network
      await Future.delayed(const Duration(milliseconds: 300));
      return;
    }
    
    try {
      await _apiService.post('/auth/logout', {});
    } catch (e) {
      throw AuthException('Logout failed: $e');
    }
  }

  /// Get current user
  Future<UserModel> getCurrentUser() async {
    if (_useMockData) {
      // Return user pertama sebagai current user
      final users = MockUsersData.getAllUsers();
      final user = users.first;
      
      return UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        profileImage: user.profileImage,
        createdAt: user.createdAt,
      );
    }
    
    try {
      final response = await _apiService.get('/auth/me');
      return UserModel.fromJson(response['user'] as Map<String, dynamic>);
    } catch (e) {
      throw AuthException('Failed to get current user: $e');
    }
  }
}

/// Exception untuk error autentikasi
class AuthException implements Exception {
  final String message;
  
  const AuthException(this.message);
  
  @override
  String toString() => 'AuthException: $message';
}