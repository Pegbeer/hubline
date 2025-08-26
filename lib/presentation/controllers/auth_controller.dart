import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hubline/routes/app_routes.dart';
import 'package:hubline/data/services/api_service.dart';
import 'package:hubline/data/models/auth_models.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ApiService _apiService = Get.find<ApiService>();

  final RxBool isLoading = false.obs;
  final Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
    ever(user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      if (Get.currentRoute != AppRoutes.login) {
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      // Login with Firebase first
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        // Get Firebase ID token and authenticate with backend
        final idToken = await result.user!.getIdToken();
        final request = LoginRequest(idToken: idToken!);
        final loginResponse = await _apiService.loginUser(request);

        // Validate backend login was successful
        if (loginResponse.user.firebaseUid != result.user!.uid) {
          throw Exception('Backend login failed: UID mismatch');
        }

        // Store authentication token and user data if needed
        // await _storeAuthToken(loginResponse.token);
        // await _storeUserData(loginResponse.user);
      }

      Get.snackbar('success'.tr, 'login_success'.tr);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('error'.tr, _getAuthErrorMessage(e.code));
    } catch (e) {
      Get.snackbar('error'.tr, 'Failed to login with backend: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      isLoading.value = true;
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await result.user?.updateDisplayName(name);

      if (result.user != null) {
        final idToken = await result.user!.getIdToken();
        final request = RegisterRequest(idToken: idToken!, name: name);
        final userResponse = await _apiService.registerUser(request);

        // Validate backend registration was successful
        if (userResponse.firebaseUid != result.user!.uid) {
          throw Exception('Backend registration failed: UID mismatch');
        }

        // Store user data if needed
        // await _storeUserData(userResponse);
      }

      Get.snackbar('success'.tr, 'register_success'.tr);
    } on FirebaseAuthException catch (e) {
      print(e);
      Get.snackbar('error'.tr, _getAuthErrorMessage(e.code));
    } catch (e) {
      print(e);
      Get.snackbar('error'.tr, 'Failed to register with backend: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // Sign out first to ensure clean state

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);

      if (result.user != null) {
        // Get Firebase ID token and authenticate with backend
        final idToken = await result.user!.getIdToken();
        final request = LoginRequest(idToken: idToken!);
        final loginResponse = await _apiService.loginUser(request);

        // Validate backend login was successful
        if (loginResponse.user.firebaseUid != result.user!.uid) {
          throw Exception('Backend login failed: UID mismatch');
        }

        // Store authentication token and user data if needed
        // await _storeAuthToken(loginResponse.token);
        // await _storeUserData(loginResponse.user);
      }

      Get.snackbar('Success', 'Signed in successfully with Google');
    } catch (e) {
      print('Google Sign In Error: $e');
      Get.snackbar('Error', 'Failed to sign in with Google: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await GoogleSignIn.instance.signOut();
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Usuario no encontrado';
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'email-already-in-use':
        return 'El correo ya está en uso';
      case 'weak-password':
        return 'La contraseña es muy débil';
      default:
        return 'Error de autenticación';
    }
  }
}
