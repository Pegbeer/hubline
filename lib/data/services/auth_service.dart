import 'dart:convert';
import 'package:get/get.dart';
import 'package:hubline/data/models/auth_models.dart';
import 'package:hubline/data/services/secure_storage_service.dart';
import 'package:hubline/data/services/api_service.dart';

class AuthService extends GetxService {
  final SecureStorageService _secureStorage = Get.find<SecureStorageService>();
  final ApiService _apiService = Get.find<ApiService>();

  final Rx<AuthenticatedUser?> _currentUser = Rx<AuthenticatedUser?>(null);
  final RxBool _isLoading = false.obs;

  AuthenticatedUser? get currentUser => _currentUser.value;
  UserDto? get user => _currentUser.value?.user;
  String? get token => _currentUser.value?.token;
  bool get isAuthenticated => _currentUser.value != null;
  bool get isLoading => _isLoading.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadStoredUser();
  }

  Future<void> _loadStoredUser() async {
    try {
      _isLoading.value = true;
      
      final token = await _secureStorage.getJwtToken();
      final userDataJson = await _secureStorage.getUserData();
      
      if (token != null && userDataJson != null) {
        final userData = json.decode(userDataJson);
        final user = UserDto.fromJson(userData);
        
        _currentUser.value = AuthenticatedUser(
          token: token,
          user: user,
        );
      }
    } catch (e) {
      await _clearAuthData();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<AuthenticatedUser> login(String idToken) async {
    try {
      _isLoading.value = true;
      
      final loginRequest = LoginRequest(idToken: idToken);
      final loginResponse = await _apiService.loginUser(loginRequest);
      
      final authenticatedUser = AuthenticatedUser.fromLoginResponse(loginResponse);
      
      // Save to secure storage
      await _secureStorage.saveJwtToken(authenticatedUser.token);
      await _secureStorage.saveUserData(json.encode(authenticatedUser.user.toJson()));
      
      _currentUser.value = authenticatedUser;
      
      return authenticatedUser;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<AuthenticatedUser> register(String idToken, String name) async {
    try {
      _isLoading.value = true;
      
      final registerRequest = RegisterRequest(idToken: idToken, name: name);
      final registerResponse = await _apiService.registerUser(registerRequest);
      
      // After registration, login with the same idToken
      return await login(idToken);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      _isLoading.value = true;
      await _clearAuthData();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _clearAuthData() async {
    await _secureStorage.clearAll();
    _currentUser.value = null;
  }

  Future<void> updateUserData(UserDto updatedUser) async {
    if (_currentUser.value != null) {
      final updatedAuth = AuthenticatedUser(
        token: _currentUser.value!.token,
        user: updatedUser,
      );
      
      _currentUser.value = updatedAuth;
      await _secureStorage.saveUserData(json.encode(updatedUser.toJson()));
    }
  }
}