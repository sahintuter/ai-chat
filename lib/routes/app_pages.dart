import 'package:get/get.dart';
import '../screens/login_screen.dart';
import '../screens/character_selection_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/token_reward_screen.dart';
import '../screens/chats_screen.dart';
import '../bindings/app_binding.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => const LoginScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => const CharacterSelectionScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: '/chat',
      page: () => const ChatScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: '/profile',
      page: () => const ProfileScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: '/tokens',
      page: () => const TokenRewardScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: '/chats',
      page: () => const ChatsScreen(),
      binding: AppBinding(),
    ),
  ];
}
