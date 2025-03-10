import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../constants/app_sizes.dart';
import '../constants/app_theme.dart';
import '../controllers/profile_controller.dart';
import '../widgets/scaffold_layout.dart';

class CharacterSelectionScreen extends GetView<NavigationController> {
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> characters = [
      {
        'image': 'https://picsum.photos/200',
        'name': 'Sarah',
        'personality': 'Neşeli ve Enerjik'
      },
      {
        'image': 'https://picsum.photos/200',
        'name': 'Emma',
        'personality': 'Romantik ve Düşünceli'
      },
      {
        'image': 'https://picsum.photos/200',
        'name': 'Alice',
        'personality': 'Romantik'
      },
      // Diğer karakterler...
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
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Text(
                'Karakter Seçin',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: AppSizes.screenWidth(context) > 600 ? 3 : 2,
                  crossAxisSpacing: AppSizes.paddingM,
                  mainAxisSpacing: AppSizes.paddingM,
                  childAspectRatio: 1,
                ),
                itemCount: characters.length,
                itemBuilder: (context, index) =>
                    _buildCharacterItem(context, characters[index]),
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
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
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
                  fontWeight: FontWeight.w500,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCharacterItem(
      BuildContext context, Map<String, String> character) {
    return GestureDetector(
      onTap: () => _selectCharacter(character),
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'character_${character['name']}_${character.hashCode}',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
                  border: Border.all(color: Colors.grey[200]!, width: 1),
                  image: DecorationImage(
                    image: NetworkImage(character['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            character['name']!,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _selectCharacter(Map<String, String> character) {
    Get.toNamed('/chat', arguments: character);
  }
}
