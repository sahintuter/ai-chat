import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/chat_controller.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../constants/app_theme.dart';
import '../constants/app_sizes.dart';
import '../widgets/scaffold_layout.dart';

class ChatsScreen extends GetView<ChatController> {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
      title: 'Sohbetler',
      automaticallyImplyLeading: false,
      body: Obx(() {
        if (controller.allChats.isEmpty) {
          return const Center(
            child: Text(
              'Henüz bir sohbet başlatmadınız',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: controller.allChats.length,
          itemBuilder: (context, index) {
            final chat = controller.allChats[index];
            final lastMessage = chat.lastMessage ?? 'Henüz mesaj yok';

            return Card(
              elevation: 1,
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(chat.character['image']!),
                ),
                title: Row(
                  children: [
                    Text(
                      chat.character['name']!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '2 dk önce',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text(
                        lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${chat.messages.length}',
                        style: GoogleFonts.poppins(
                          color: AppTheme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  controller.currentCharacter = chat.character;
                  Get.toNamed('/chat', arguments: chat.character);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
