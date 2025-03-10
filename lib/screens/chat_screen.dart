import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/scaffold_layout.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final character = Get.arguments as Map<String, dynamic>;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Get.back();
        }
      },
      child: ScaffoldLayout(
        title: character['name'] ?? 'AI Kız Arkadaş',
        body: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    reverse: true,
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      return ChatMessageBubble(message: message);
                    },
                  )),
            ),
            ChatInput(
              onSend: controller.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
