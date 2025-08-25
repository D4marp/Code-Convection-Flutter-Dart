import 'dart:convert';
import 'package:http/http.dart' as http;

/// Abstract class untuk remote data source
abstract class RemoteDataSource {
  Future<Map<String, dynamic>> get(String endpoint);
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data);
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data);
  Future<void> delete(String endpoint);
}

/// Implementation dari RemoteDataSource menggunakan HTTP
class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client _client;
  final String _baseUrl;
  
  const RemoteDataSourceImpl({
    required http.Client client,
    required String baseUrl,
  }) : _client = client, _baseUrl = baseUrl;

  @override
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl$endpoint'),
        headers: _getHeaders(),
      ).timeout(const Duration(seconds: 30));
      
      return _handleResponse(response);
    } catch (e) {
      throw ServerException('GET request failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String endpoint, 
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl$endpoint'),
        headers: _getHeaders(),
        body: json.encode(data),
      ).timeout(const Duration(seconds: 30));
      
      return _handleResponse(response);
    } catch (e) {
      throw ServerException('POST request failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> put(
    String endpoint, 
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _client.put(
        Uri.parse('$_baseUrl$endpoint'),
        headers: _getHeaders(),
        body: json.encode(data),
      ).timeout(const Duration(seconds: 30));
      
      return _handleResponse(response);
    } catch (e) {
      throw ServerException('PUT request failed: $e');
    }
  }

  @override
  Future<void> delete(String endpoint) async {
    try {
      final response = await _client.delete(
        Uri.parse('$_baseUrl$endpoint'),
        headers: _getHeaders(),
      ).timeout(const Duration(seconds: 30));
      
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException('Delete failed: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('DELETE request failed: $e');
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
      throw ServerException(
        'Request failed with status: ${response.statusCode}',
      );
    }
  }
}

/// Exception untuk server operations
class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
  
  @override
  String toString() => 'ServerException: $message';
}