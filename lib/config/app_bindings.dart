import 'package:get/get.dart';
import 'package:hubline/presentation/controllers/auth_controller.dart';
import 'package:hubline/presentation/controllers/home_controller.dart';
import 'package:hubline/presentation/controllers/profile_controller.dart';
import 'package:hubline/data/services/api_service.dart';
import 'package:hubline/data/services/secure_storage_service.dart';
import 'package:hubline/data/services/auth_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Services - Initialize in order of dependency
    Get.put<SecureStorageService>(SecureStorageService(), permanent: true);
    Get.put<ApiService>(ApiService(), permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
    
    // Controllers
    // Solo inicializar si no existe ya
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    }
    // HomeController como singleton permanente para mantener estado de navegación
    Get.put<HomeController>(HomeController(), permanent: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
