/// Application constants mengikuti naming convention
class AppConstants {
  // Private constructor untuk mencegah instantiation
  AppConstants._();
  
  // API Configuration
  static const String API_BASE_URL = 'https://api.example.com';
  static const Duration API_TIMEOUT = Duration(seconds: 30);
  static const int API_RETRY_COUNT = 3;
  
  // Cache Configuration
  static const String CACHE_KEY_USER = 'cached_user';
  static const String CACHE_KEY_PRODUCTS = 'cached_products';
  static const Duration CACHE_DURATION = Duration(hours: 24);
  
  // UI Configuration
  static const double DEFAULT_PADDING = 16.0;
  static const double DEFAULT_MARGIN = 8.0;
  static const double DEFAULT_BORDER_RADIUS = 8.0;
  static const int DEFAULT_ANIMATION_DURATION_MS = 300;
  
  // Validation Rules
  static const int MIN_PASSWORD_LENGTH = 8;
  static const int MAX_NAME_LENGTH = 50;
  static const int MAX_DESCRIPTION_LENGTH = 500;
  
  // Error Messages
  static const String ERROR_NETWORK = 'Network error occurred';
  static const String ERROR_CACHE = 'Cache error occurred';
  static const String ERROR_UNKNOWN = 'Unknown error occurred';
  static const String ERROR_VALIDATION = 'Validation error';
  
  // Success Messages
  static const String SUCCESS_LOGIN = 'Login successful';
  static const String SUCCESS_LOGOUT = 'Logout successful';
  static const String SUCCESS_SAVE = 'Data saved successfully';
  static const String SUCCESS_DELETE = 'Data deleted successfully';
  
  // Route Names
  static const String ROUTE_LOGIN = '/login';
  static const String ROUTE_HOME = '/home';
  static const String ROUTE_PROFILE = '/profile';
  static const String ROUTE_PRODUCTS = '/products';
  static const String ROUTE_PRODUCT_DETAIL = '/product-detail';
  
  // SharedPreferences Keys
  static const String PREF_USER_TOKEN = 'user_token';
  static const String PREF_USER_ID = 'user_id';
  static const String PREF_THEME_MODE = 'theme_mode';
  static const String PREF_LANGUAGE = 'language';
}