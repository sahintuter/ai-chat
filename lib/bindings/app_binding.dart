import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/chat_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/profile_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => NavigationController());
    Get.lazyPut(() => ProfileController());
  }
}
