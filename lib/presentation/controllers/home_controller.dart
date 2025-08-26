import 'package:get/get.dart';

class HomeController extends GetxController {
  static const String _selectedIndexKey = 'selected_index';

  final RxInt selectedIndex = 0.obs;

  void changeTab(int index) {
    print('HomeController: Changing tab from ${selectedIndex.value} to $index');
    // Pequeño delay para permitir que la animación del botón se complete primero
    Future.delayed(const Duration(milliseconds: 75), () {
      selectedIndex.value = index;
    });
  }

  // Método para reinicializar si es necesario
  void resetToHome() {
    selectedIndex.value = 0;
  }

  @override
  void onInit() {
    super.onInit();
    print(
      'HomeController: onInit called, selectedIndex = ${selectedIndex.value}',
    );
    // Asegurar que el estado inicial sea correcto
    selectedIndex.value = 0;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
