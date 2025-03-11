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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingS,
      ),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) _buildAvatar(context),
          const SizedBox(width: AppSizes.paddingS),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              decoration: BoxDecoration(
                color: message.isUser
                    ? AppTheme.primaryColor
                    : isDarkMode
                        ? AppTheme.darkCardColor
                        : Colors.grey[200],
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
              child: Text(
                message.text,
                style: GoogleFonts.poppins(
                  color: message.isUser
                      ? Colors.white
                      : isDarkMode
                          ? AppTheme.darkTextColor
                          : AppTheme.lightTextColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.paddingS),
          if (message.isUser) _buildAvatar(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return CircleAvatar(
      radius: 16,
      backgroundColor: message.isUser
          ? AppTheme.primaryColor.withAlpha(204)
          : isDarkMode
              ? AppTheme.darkCardColor
              : AppTheme.lightCardColor,
      child: Icon(
        message.isUser ? Icons.person : Icons.android,
        color: message.isUser ? Colors.white : AppTheme.primaryColor,
        size: 18,
      ),
    );
  }
}
