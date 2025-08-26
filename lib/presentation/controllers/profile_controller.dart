import 'package:get/get.dart';
import 'package:hubline/data/models/user_model.dart';

class ProfileController extends GetxController {
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
      // TODO: Implement user profile loading from Firebase
      await Future.delayed(const Duration(seconds: 1)); // Simulate loading
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cargar el perfil');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    try {
      isLoading.value = true;
      // TODO: Implement profile update to Firebase
      user.value = updatedUser;
      Get.snackbar('Éxito', 'Perfil actualizado correctamente');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar el perfil');
    } finally {
      isLoading.value = false;
    }
  }
}