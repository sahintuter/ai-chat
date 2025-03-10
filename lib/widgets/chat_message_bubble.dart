import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/chat_message.dart';
import '../constants/app_theme.dart';
import '../constants/app_sizes.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingS,
      ),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) _buildAvatar(),
          const SizedBox(width: AppSizes.paddingS),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              decoration: BoxDecoration(
                color:
                    message.isUser ? AppTheme.primaryColor : Colors.grey[200],
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
              child: Text(
                message.text,
                style: GoogleFonts.poppins(
                  color: message.isUser ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.paddingS),
          if (message.isUser) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 16,
      backgroundColor: message.isUser ? Colors.blue : AppTheme.primaryColor,
      child: Icon(
        message.isUser ? Icons.person : Icons.android,
        color: Colors.white,
        size: 18,
      ),
    );
  }
}
