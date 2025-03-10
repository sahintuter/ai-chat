import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changePage(int index) {
    if (currentIndex.value == index) return;

    currentIndex.value = index;
    switch (index) {
      case 0:
        // Önceki sayfaları korumak için offAll yerine toNamed ve predicate kullan
        Get.until((route) => route.settings.name == '/home' || route.isFirst);
        if (Get.currentRoute != '/home') {
          Get.toNamed('/home');
        }
        break;
      case 1:
        Get.until((route) => route.settings.name == '/chats' || route.isFirst);
        if (Get.currentRoute != '/chats') {
          Get.toNamed('/chats');
        }
        break;
      case 2:
        Get.until(
            (route) => route.settings.name == '/profile' || route.isFirst);
        if (Get.currentRoute != '/profile') {
          Get.toNamed('/profile');
        }
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Route'a göre current index'i ayarla
    ever(currentIndex, (_) => update());
  }
}
