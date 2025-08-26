import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class AppConfig {
  static const String appName = 'HubLine';
  static const String baseUrl = 'https://api.hubline.com';
  
  // Firebase Configuration from environment
  static String get firebaseApiKey {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return dotenv.env['FIREBASE_API_KEY_ANDROID'] ?? '';
    } else {
      return dotenv.env['FIREBASE_API_KEY_IOS'] ?? '';
    }
  }
  
  static String get firebaseAppId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return dotenv.env['FIREBASE_APP_ID_ANDROID'] ?? '';
    } else {
      return dotenv.env['FIREBASE_APP_ID_IOS'] ?? '';
    }
  }
  
  static String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  
  // Google Sign In Configuration
  static String get googleClientId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return dotenv.env['GOOGLE_ANDROID_CLIENT_ID'] ?? '';
    } else {
      return dotenv.env['GOOGLE_IOS_CLIENT_ID'] ?? '';
    }
  }
  
  static String get googleServerClientId => dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '';
  
  // Pagination
  static const int itemsPerPage = 20;
  
  // Image Configuration
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png'];
}