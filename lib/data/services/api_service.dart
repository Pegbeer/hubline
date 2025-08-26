import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hubline/data/models/auth_models.dart';
import 'package:hubline/data/services/secure_storage_service.dart';

class ApiService extends GetxService {
  static const String baseUrl = 'http://192.168.1.212:8080/api';
  late final Dio _dio;
  late final SecureStorageService _secureStorage;

  @override
  void onInit() {
    super.onInit();
    _secureStorage = Get.find<SecureStorageService>();
    
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    // JWT Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Skip adding token for auth endpoints
          if (!options.path.startsWith('/auth/')) {
            final token = await _secureStorage.getJwtToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          // Handle 401 Unauthorized - token expired
          if (error.response?.statusCode == 401) {
            await _secureStorage.clearAll();
            // Navigate to login or refresh token logic here
          }
          handler.next(error);
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  Future<RegisterResponse> registerUser(RegisterRequest request) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: request.toJson(),
      );

      final apiResponse = ApiResponse<RegisterResponse>.fromJson(
        response.data,
        (json) => RegisterResponse.fromJson(json as Map<String, dynamic>),
      );

      if (!apiResponse.success) {
        throw Exception(apiResponse.error ?? 'Registration failed');
      }

      if (apiResponse.data == null) {
        throw Exception('No user data received from server');
      }

      return apiResponse.data!;
    } on DioException catch (e) {
      throw Exception(
        'Failed to register user: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<LoginResponse> loginUser(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: request.toJson(),
      );

      final apiResponse = ApiResponse<LoginResponse>.fromJson(
        response.data,
        (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
      );

      if (!apiResponse.success) {
        throw Exception(apiResponse.error ?? 'Login failed');
      }

      if (apiResponse.data == null) {
        throw Exception('No login data received from server');
      }

      return apiResponse.data!;
    } on DioException catch (e) {
      throw Exception(
        'Failed to login user: ${e.response?.data ?? e.message}',
      );
    }
  }
}
