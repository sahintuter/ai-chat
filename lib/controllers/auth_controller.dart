import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool isLoggedIn = false.obs;

  void login() {
    isLoggedIn.value = true;
    Get.offAllNamed('/home');
  }

  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed('/');
  }
}
