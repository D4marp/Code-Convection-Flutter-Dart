# 📋 Flutter Code Conventions & Best Practices

## 📖 Daftar Isi
- [1. Struktur Proyek](#1-struktur-proyek)
- [2. Naming Conventions](#2-naming-conventions)
- [3. Clean Architecture](#3-clean-architecture)
- [4. File Organization](#4-file-organization)
- [5. Code Style Guidelines](#5-code-style-guidelines)
- [6. Documentation Standards](#6-documentation-standards)
- [7. Error Handling](#7-error-handling)
- [8. State Management](#8-state-management)
- [9. Widget Guidelines](#9-widget-guidelines)
- [10. Testing Conventions](#10-testing-conventions)

---

## 1. Struktur Proyek

### 📁 Recommended Project Structure
```
lib/
├── core/                    # Business logic & shared functionality
│   ├── data/               # Data layer implementation
│   │   ├── datasources/    # Local & remote data sources
│   │   └── static/         # Mock data & constants
│   ├── domain/             # Business logic layer
│   │   └── repositories/   # Repository interfaces
│   ├── entities/           # Domain entities (pure Dart)
│   ├── models/             # Data models with JSON serialization
│   ├── repositories/       # Repository implementations
│   ├── services/           # External services (API, etc.)
│   └── utils/              # Core utilities
├── features/               # Feature-based modules
│   ├── auth/              # Authentication feature
│   │   ├── providers/     # State management
│   │   └── screens/       # UI screens
│   └── home/              # Home feature
├── shared/                 # Reusable components
│   ├── constants/         # App-wide constants
│   ├── themes/            # Theme configurations
│   └── widgets/           # Reusable widgets
└── utils/                  # General utilities
    ├── extensions.dart    # Dart extensions
    └── validators.dart    # Form validators
```

### 🎯 Prinsip Organisasi
- **Feature-based**: Grup kode berdasarkan fitur, bukan tipe file
- **Layer separation**: Pisahkan concerns (UI, business logic, data)
- **Reusability**: Komponen yang dapat digunakan ulang di folder `shared/`
- **Scalability**: Struktur yang mudah dikembangkan

---

## 2. Naming Conventions

### 📝 File & Directory Names
```dart
// ✅ BENAR - snake_case untuk files & directories
user_profile_screen.dart
auth_repository.dart
api_service.dart

// ❌ SALAH
UserProfileScreen.dart
authRepository.dart
APIService.dart
```

### 🏷️ Class Names
```dart
// ✅ BENAR - PascalCase untuk classes
class UserProfileScreen extends StatelessWidget {}
class AuthRepository {}
class ApiService {}

// ❌ SALAH
class userProfileScreen {}
class authRepository {}
class apiService {}
```

### 🔤 Variable & Method Names
```dart
// ✅ BENAR - camelCase untuk variables & methods
String userName = 'John';
bool isAuthenticated = false;
void getUserProfile() {}

// ❌ SALAH
String user_name = 'John';
bool IsAuthenticated = false;
void get_user_profile() {}
```

### 📊 Constants
```dart
// ✅ BENAR - SCREAMING_SNAKE_CASE untuk constants
static const String API_BASE_URL = 'https://api.example.com';
static const int MAX_RETRY_COUNT = 3;
static const Duration DEFAULT_TIMEOUT = Duration(seconds: 30);

// ❌ SALAH
static const String apiBaseUrl = 'https://api.example.com';
static const int maxRetryCount = 3;
```

### 🛣️ Route Names
```dart
// ✅ BENAR - kebab-case dengan prefix slash
static const String ROUTE_LOGIN = '/login';
static const String ROUTE_USER_PROFILE = '/user-profile';
static const String ROUTE_PRODUCT_DETAIL = '/product-detail';
```

---

## 3. Clean Architecture

### 🏗️ Layer Structure

#### **1. Presentation Layer** (`features/`)
```dart
// Screens - UI components
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  // UI implementation
}

// Providers - State management
class AuthProvider extends ChangeNotifier {
  // State management logic
}
```

#### **2. Domain Layer** (`core/entities/`, `core/domain/`)
```dart
// Entities - Pure business objects
class UserEntity {
  final String id;
  final String name;
  final String email;
  
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });
}

// Repository Interfaces
abstract class UserRepository {
  Future<UserEntity> getUserById(String id);
  Future<List<UserEntity>> getAllUsers();
}
```

#### **3. Data Layer** (`core/data/`, `core/models/`, `core/repositories/`)
```dart
// Models - Data transfer objects
class UserModel {
  final String id;
  final String name;
  final String email;
  
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}

// Repository Implementation
class UserRepositoryImpl implements UserRepository {
  final ApiService _apiService;
  
  const UserRepositoryImpl(this._apiService);
  
  @override
  Future<UserEntity> getUserById(String id) async {
    final model = await _apiService.getUser(id);
    return UserEntity(
      id: model.id,
      name: model.name,
      email: model.email,
    );
  }
}
```

---

## 4. File Organization

### 📂 Import Organization
```dart
// 1. Dart core libraries
import 'dart:async';
import 'dart:convert';

// 2. Flutter libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. Third-party packages
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// 4. Internal imports - relative paths
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../../shared/widgets/custom_button.dart';
```

### 🎯 Export Organization
```dart
// barrel exports untuk kemudahan import
// lib/core/core.dart
export 'entities/user_entity.dart';
export 'models/user_model.dart';
export 'repositories/auth_repository.dart';
export 'services/api_service.dart';
```

---

## 5. Code Style Guidelines

### 🎨 Widget Construction
```dart
// ✅ BENAR - Const constructors untuk performance
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading 
          ? const CircularProgressIndicator()
          : Text(text),
    );
  }
}
```

### 🔒 Immutability
```dart
// ✅ BENAR - Immutable data classes
class UserEntity {
  final String id;
  final String name;
  final String email;
  
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });
  
  // Copy with method untuk updates
  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
```

### 🛡️ Null Safety
```dart
// ✅ BENAR - Proper null safety
String? getUserName(User? user) {
  return user?.name;
}

// Null-aware operators
final displayName = user?.name ?? 'Unknown';
user?.updateProfile();

// Late initialization
late final AuthService _authService;
```

---

## 6. Documentation Standards

### 📚 Class Documentation
```dart
/// Repository untuk menangani operasi autentikasi user.
/// 
/// Menyediakan method untuk login, logout, dan registrasi.
/// Menggunakan [ApiService] untuk komunikasi dengan backend.
/// 
/// Example:
/// ```dart
/// final authRepo = AuthRepository(apiService);
/// final user = await authRepo.login('email@example.com', 'password');
/// ```
class AuthRepository {
  final ApiService _apiService;
  
  /// Membuat instance [AuthRepository] dengan [ApiService] yang diperlukan.
  const AuthRepository(this._apiService);
  
  /// Login user dengan [email] dan [password].
  /// 
  /// Returns [UserModel] jika berhasil.
  /// Throws [AuthException] jika gagal.
  Future<UserModel> login(String email, String password) async {
    // Implementation
  }
}
```

### 📝 Method Documentation
```dart
/// Validasi format email.
/// 
/// Parameters:
/// - [value]: String email yang akan divalidasi
/// 
/// Returns:
/// - `null` jika email valid
/// - Error message jika email tidak valid
/// 
/// Example:
/// ```dart
/// final error = Validators.validateEmail('test@example.com');
/// if (error != null) {
///   print('Email tidak valid: $error');
/// }
/// ```
static String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email tidak boleh kosong';
  }
  
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Format email tidak valid';
  }
  
  return null;
}
```

---

## 7. Error Handling

### 🚨 Type-Safe Error Handling
```dart
/// Result class untuk error handling yang type-safe
sealed class Result<T> {
  const Result();
}

/// Success result dengan data
final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

/// Failure result dengan error
final class Failure<T> extends Result<T> {
  final String message;
  final Exception? exception;
  
  const Failure(this.message, [this.exception]);
}

// Usage
Future<Result<UserModel>> getUser(String id) async {
  try {
    final user = await _apiService.getUser(id);
    return Success(user);
  } catch (e) {
    return Failure('Failed to get user', e as Exception);
  }
}
```

### 🎯 Custom Exceptions
```dart
/// Base exception class untuk aplikasi
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, [this.code]);
  
  @override
  String toString() => 'AppException: $message';
}

/// Exception untuk error autentikasi
class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
}

/// Exception untuk error network
class NetworkException extends AppException {
  const NetworkException(super.message, [super.code]);
}
```

---

## 8. State Management

### 🔄 Provider Pattern
```dart
/// Provider untuk menangani state autentikasi
class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  
  AuthProvider(this._authRepository);
  
  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;
  
  /// Login user
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      _currentUser = await _authRepository.login(email, password);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
  
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }
  
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
```

### 🏗️ Dependency Injection
```dart
// main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<ApiService>(
          create: (_) => ApiService(),
        ),
        
        // Repositories
        ProxyProvider<ApiService, AuthRepository>(
          update: (_, apiService, __) => AuthRepository(apiService),
        ),
        
        // Providers
        ChangeNotifierProxyProvider<AuthRepository, AuthProvider>(
          create: (context) => AuthProvider(
            Provider.of<AuthRepository>(context, listen: false),
          ),
          update: (_, authRepository, previous) =>
              previous ?? AuthProvider(authRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        home: const AuthWrapper(),
      ),
    );
  }
}
```

---

## 9. Widget Guidelines

### 🎨 Reusable Widgets
```dart
/// Custom button widget yang dapat digunakan di seluruh aplikasi
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 48,
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          foregroundColor: textColor ?? Colors.white,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text),
      ),
    );
  }
}
```

### 📱 Responsive Design
```dart
/// Extension untuk responsive design
extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;
  
  double responsiveValue({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}

// Usage
Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(
      context.responsiveValue(
        mobile: 16.0,
        tablet: 24.0,
        desktop: 32.0,
      ),
    ),
    child: Text('Responsive Text'),
  );
}
```

---

## 10. Testing Conventions

### 🧪 Unit Tests
```dart
// test/validators_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateEmail', () {
      test('should return null for valid email', () {
        // Arrange
        const email = 'test@example.com';
        
        // Act
        final result = Validators.validateEmail(email);
        
        // Assert
        expect(result, isNull);
      });
      
      test('should return error for invalid email', () {
        // Arrange
        const email = 'invalid-email';
        
        // Act
        final result = Validators.validateEmail(email);
        
        // Assert
        expect(result, equals('Format email tidak valid'));
      });
      
      test('should return error for empty email', () {
        // Arrange
        const email = '';
        
        // Act
        final result = Validators.validateEmail(email);
        
        // Assert
        expect(result, equals('Email tidak boleh kosong'));
      });
    });
  });
}
```

### 🎭 Widget Tests
```dart
// test/widgets/custom_button_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/shared/widgets/custom_button.dart';

void main() {
  group('CustomButton', () {
    testWidgets('should display text when not loading', (tester) async {
      // Arrange
      const buttonText = 'Test Button';
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: buttonText,
              onPressed: () {},
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.text(buttonText), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
    
    testWidgets('should display loading indicator when loading', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Test Button',
              isLoading: true,
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test Button'), findsNothing);
    });
  });
}
```

---

## 📋 Checklist Code Review

### ✅ Code Quality Checklist
- [ ] **Naming**: Mengikuti naming conventions (camelCase, PascalCase, snake_case)
- [ ] **Structure**: File terorganisir sesuai clean architecture
- [ ] **Documentation**: Class dan method memiliki dokumentasi yang jelas
- [ ] **Null Safety**: Menggunakan null safety dengan benar
- [ ] **Immutability**: Data classes bersifat immutable
- [ ] **Error Handling**: Menggunakan proper error handling
- [ ] **Performance**: Menggunakan const constructors dan optimasi lainnya
- [ ] **Testing**: Memiliki unit tests dan widget tests
- [ ] **Accessibility**: Widget dapat diakses dengan screen reader
- [ ] **Responsive**: UI responsive untuk berbagai ukuran layar

### 🔍 Code Review Questions
1. Apakah kode mudah dibaca dan dipahami?
2. Apakah naming conventions sudah konsisten?
3. Apakah ada code duplication yang bisa di-refactor?
4. Apakah error handling sudah adequate?
5. Apakah ada potential memory leaks?
6. Apakah performance sudah optimal?
7. Apakah ada security concerns?
8. Apakah tests sudah comprehensive?

---

## 🛠️ Tools & Linting

### 📐 Analysis Options
```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    # Dart Style
    prefer_single_quotes: true
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    
    # Error Prevention
    avoid_print: true
    avoid_unnecessary_containers: true
    avoid_web_libraries_in_flutter: true
    
    # Performance
    prefer_const_declarations: true
    prefer_final_fields: true
    prefer_final_locals: true
    
    # Code Organization
    directives_ordering: true
    sort_child_properties_last: true
    
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  
  strong-mode:
    implicit-casts: false
    implicit-dynamic: false
```

### 🔧 VS Code Settings
```json
// .vscode/settings.json
{
  "dart.previewFlutterUiGuides": true,
  "dart.previewFlutterUiGuidesCustomTracking": true,
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true,
    "source.organizeImports": true
  },
  "dart.lineLength": 80,
  "[dart]": {
    "editor.rulers": [80],
    "editor.selectionHighlight": false,
    "editor.suggest.snippetsPreventQuickSuggestions": false,
    "editor.suggestSelection": "first",
    "editor.tabCompletion": "onlySnippets",
    "editor.wordBasedSuggestions": false
  }
}
```

---

## 📚 Resources

### 📖 Official Documentation
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Flutter Best Practices](https://flutter.dev/docs/development/best-practices)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Medium](hhttps://damargalih12.medium.com/transformasi-kode-flutter-dari-chaos-ke-clean-architecture-dengan-refactoring-patterns-61535876c026)

### 🎯 Community Guidelines
- [Flutter Community Style Guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)

---

**💡 Tips**: Konsistensi adalah kunci! Pastikan seluruh tim mengikuti conventions yang sama untuk maintainability yang optimal.
        