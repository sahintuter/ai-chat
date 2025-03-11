import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/chat_controller.dart';
import '../constants/app_sizes.dart';
import '../constants/app_theme.dart';
import '../controllers/profile_controller.dart';
import '../widgets/scaffold_layout.dart';

class CharacterSelectionScreen extends GetView<NavigationController> {
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> characters = [
      {
        'image': 'https://picsum.photos/200',
        'name': 'Sarah',
        'personality': 'Neşeli ve Enerjik',
        'description':
            'Hayat dolu ve pozitif bir karaktere sahip. Her zaman gülümsemeyi sever.'
      },
      {
        'image': 'https://picsum.photos/200',
        'name': 'Emma',
        'personality': 'Romantik ve Düşünceli',
        'description':
            'Duygusal ve anlayışlı bir yapıya sahip. İyi bir dinleyicidir.'
      },
      {
        'image': 'https://picsum.photos/200',
        'name': 'Alice',
        'personality': 'Romantik',
        'description':
            'Hayalperest ve yaratıcı bir ruha sahip. Sanat ve müzikle ilgilenir.'
      },
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Get.offAllNamed('/');
        }
      },
      child: ScaffoldLayout(
        title: 'Karakter Seçin',
        automaticallyImplyLeading: false,
        actions: [
          _buildPointsBadge(),
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sohbet Arkadaşını Seç',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? AppTheme.darkTextColor
                          : AppTheme.lightTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kendine en uygun karakteri seç ve sohbete başla',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode
                          ? AppTheme.darkTextColor.withAlpha(204)
                          : AppTheme.lightTextColor.withAlpha(204),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                itemCount: characters.length,
                itemBuilder: (context, index) =>
                    _buildCharacterCard(context, characters[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsBadge() {
    final profileController = Get.find<ProfileController>();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingS,
        vertical: AppSizes.paddingXS,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withAlpha(26),
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite, color: AppTheme.primaryColor, size: 16),
          const SizedBox(width: AppSizes.paddingXS),
          Obx(() => Text(
                '${profileController.remainingTokens}',
                style: GoogleFonts.poppins(
                  color: AppTheme.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCharacterCard(
      BuildContext context, Map<String, String> character) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingL),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
      ),
      child: InkWell(
        onTap: () => _selectCharacter(character),
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSizes.radiusL),
              ),
              child: Hero(
                tag: 'character_${character['name']}_${character.hashCode}',
                child: Image.network(
                  character['image']!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        character['name']!,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? AppTheme.darkTextColor
                              : AppTheme.lightTextColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(AppSizes.radiusS),
                        ),
                        child: Text(
                          character['personality']!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    character['description']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode
                          ? AppTheme.darkTextColor.withAlpha(204)
                          : AppTheme.lightTextColor.withAlpha(204),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectCharacter(Map<String, String> character) {
    final chatController = Get.find<ChatController>();
    chatController.startNewChat(character);
    Get.toNamed('/chat', arguments: character);
  }
}
