import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final RxInt totalChats = 0.obs;
  final RxInt totalMessages = 0.obs;
  final RxInt remainingTokens = 100.obs; // Başlangıç token miktarı
  final RxBool notificationsEnabled = true.obs;
  final RxBool darkModeEnabled = false.obs;

  static const int dailyTokenLimit = 100;
  static const int rewardAmount = 50;
  DateTime? lastTokenResetTime;

  @override
  void onInit() {
    super.onInit();
    _loadTokenData();
  }

  Future<void> _loadTokenData() async {
    final prefs = await SharedPreferences.getInstance();
    remainingTokens.value = prefs.getInt('remainingTokens') ?? dailyTokenLimit;
    final lastResetStr = prefs.getString('lastTokenResetTime');
    if (lastResetStr != null) {
      lastTokenResetTime = DateTime.parse(lastResetStr);
      _checkDailyReset();
    }
  }

  Future<void> _saveTokenData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remainingTokens', remainingTokens.value);
    await prefs.setString(
        'lastTokenResetTime', DateTime.now().toIso8601String());
  }

  void _checkDailyReset() {
    if (lastTokenResetTime == null) return;

    final now = DateTime.now();
    if (now.difference(lastTokenResetTime!).inHours >= 24) {
      remainingTokens.value = dailyTokenLimit;
      lastTokenResetTime = now;
      _saveTokenData();
    }
  }

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
  }

  void toggleDarkMode() {
    darkModeEnabled.value = !darkModeEnabled.value;
  }

  void logout() {
    Get.offAllNamed('/');
  }

  void useTokens(int amount) {
    if (remainingTokens.value >= amount) {
      remainingTokens.value -= amount;
      _saveTokenData();
    }
  }

  void earnTokens() {
    remainingTokens.value += rewardAmount;
    _saveTokenData();
  }

  bool canUseTokens(int amount) {
    return remainingTokens.value >= amount;
  }
}
