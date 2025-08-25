import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/static/mock_users_data.dart';

/// Service untuk menangani semua komunikasi API
class ApiService {
  static const String _baseUrl = 'https://api.example.com';
  static const Duration _timeout = Duration(seconds: 30);
  
  // Flag untuk menggunakan mock data (set true untuk testing)
  static const bool _useMockData = true;

  /// Melakukan GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    if (_useMockData) {
      return _handleMockGet(endpoint);
    }
    
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl$endpoint'),
            headers: _getHeaders(),
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw ApiException('GET request failed: $e');
    }
  }

  /// Melakukan POST request
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    if (_useMockData) {
      return _handleMockPost(endpoint, data);
    }
    
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl$endpoint'),
            headers: _getHeaders(),
            body: json.encode(data),
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw ApiException('POST request failed: $e');
    }
  }

  /// Handle mock GET requests
  Future<Map<String, dynamic>> _handleMockGet(String endpoint) async {
    // Simulasi delay network
    await Future.delayed(const Duration(milliseconds: 300));
    
    switch (endpoint) {
      case '/auth/me':
        // Return current user data
        final users = MockUsersData.getAllUsers();
        final user = users.first;
        return {
          'user': {
            'id': user.id,
            'name': user.name,
            'email': user.email,
            'profile_image': user.profileImage,
            'created_at': user.createdAt.toIso8601String(),
          }
        };
      
      case '/users':
        // Return all users
        final users = MockUsersData.getAllUsers();
        return {
          'users': users.map((user) => {
            'id': user.id,
            'name': user.name,
            'email': user.email,
            'profile_image': user.profileImage,
            'created_at': user.createdAt.toIso8601String(),
          }).toList()
        };
      
      default:
        throw ApiException('Mock endpoint not found: $endpoint');
    }
  }

  /// Handle mock POST requests
  Future<Map<String, dynamic>> _handleMockPost(
    String endpoint, 
    Map<String, dynamic> data,
  ) async {
    // Simulasi delay network
    await Future.delayed(const Duration(milliseconds: 500));
    
    switch (endpoint) {
      case '/auth/login':
        final email = data['email'] as String;
        final password = data['password'] as String;
        
        // Validasi credentials dummy
        final validCredentials = {
          'john.doe@example.com': 'password123',
          'jane.smith@example.com': 'password123',
          'admin@example.com': 'admin123',
        };
        
        if (validCredentials[email] == password) {
          final users = MockUsersData.getAllUsers();
          final user = users.firstWhere(
            (u) => u.email == email,
            orElse: () => throw ApiException('User not found'),
          );
          
          return {
            'user': {
              'id': user.id,
              'name': user.name,
              'email': user.email,
              'profile_image': user.profileImage,
              'created_at': user.createdAt.toIso8601String(),
            },
            'token': 'mock_jwt_token_${user.id}'
          };
        } else {
          throw ApiException('Invalid credentials');
        }
      
      case '/auth/register':
        final name = data['name'] as String;
        final email = data['email'] as String;
        
        // Simulasi registrasi berhasil
        final newUserId = 'user_${DateTime.now().millisecondsSinceEpoch}';
        return {
          'user': {
            'id': newUserId,
            'name': name,
            'email': email,
            'profile_image': null,
            'created_at': DateTime.now().toIso8601String(),
          },
          'token': 'mock_jwt_token_$newUserId'
        };
      
      case '/auth/logout':
        // Simulasi logout berhasil
        return {'message': 'Logout successful'};
      
      default:
        throw ApiException('Mock endpoint not found: $endpoint');
    }
  }

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw ApiException(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      );
    }
  }
}

/// Exception untuk error API
class ApiException implements Exception {
  final String message;
  
  const ApiException(this.message);
  
  @override
  String toString() => 'ApiException: $message';
}