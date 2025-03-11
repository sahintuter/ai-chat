import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/navigation_controller.dart';
import '../constants/app_theme.dart';
import '../constants/app_sizes.dart';
import '../controllers/theme_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';
import '../widgets/scaffold_layout.dart';
import '../controllers/chat_controller.dart';

class ProfileScreen extends GetView<NavigationController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
      title: 'Profil',
      automaticallyImplyLeading: false,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          children: [
            _buildProfileHeader(),
            const SizedBox(height: AppSizes.paddingL),
            _buildStatsSection(),
            const SizedBox(height: AppSizes.paddingL),
            _buildSettingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: AppTheme.primaryColor,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: AppSizes.paddingM),
        Text(
          'Misafir Kullanıcı',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    final profileController = Get.find<ProfileController>();
    final chatController = Get.find<ChatController>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İstatistikler',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSizes.paddingM),
            Obx(() => _buildStatItem(
                'Toplam Sohbet', '${chatController.allChats.length}')),
            Obx(() => _buildStatItem(
                'Toplam Mesaj', '${chatController.messages.length}')),
            Obx(() => _buildStatItem(
                'Kalan Token', '${profileController.remainingTokens}')),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    final profileController = Get.find<ProfileController>();
    final chatController = Get.find<ChatController>();

    return Card(
      child: Column(
        children: [
          Obx(() => ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Bildirimler'),
                trailing: Switch(
                  value: profileController.notificationsEnabled.value,
                  onChanged: (_) => profileController.toggleNotifications(),
                  activeColor: AppTheme.primaryColor,
                ),
              )),
          Obx(() => ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Karanlık Mod'),
                trailing: Switch(
                  value: Get.find<ThemeController>().isDarkMode,
                  onChanged: (_) => Get.find<ThemeController>().toggleTheme(),
                  activeColor: AppTheme.primaryColor,
                ),
              )),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Çıkış Yap'),
            onTap: () => Get.find<AuthController>().logout(),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Tüm Sohbetleri Temizle'),
            subtitle: const Text('Bu işlem geri alınamaz'),
            onTap: () => _showClearConfirmation(chatController),
          ),
        ],
      ),
    );
  }

  void _showClearConfirmation(ChatController chatController) {
    Get.dialog(
      AlertDialog(
        title: const Text('Tüm Sohbetleri Temizle'),
        content: const Text(
            'Tüm sohbet geçmişiniz silinecek. Bu işlem geri alınamaz. Devam etmek istiyor musunuz?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              chatController.clearAllChats();
            },
            child: const Text('Temizle', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingXS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
