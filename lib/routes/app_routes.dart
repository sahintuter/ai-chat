import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/character_selection_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/token_reward_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String profile = '/profile';
  static const String tokens = '/tokens';

  static Map<String, WidgetBuilder> get routes => {
        initial: (context) => const LoginScreen(),
        home: (context) => const CharacterSelectionScreen(),
        chat: (context) => const ChatScreen(),
        profile: (context) => const ProfileScreen(),
        tokens: (context) => const TokenRewardScreen(),
      };
}
