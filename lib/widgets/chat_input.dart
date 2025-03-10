import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../constants/app_sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSend;

  const ChatInput({
    super.key,
    required this.onSend,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  late final TextEditingController _textController;
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmitted() {
    final text = _textController.text;
    if (text.trim().isEmpty) return;

    widget.onSend(text);
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.darkCardColor : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDarkMode ? AppTheme.darkDividerColor : Colors.grey[200]!,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onChanged: (text) {
                setState(() {
                  _isComposing = text.trim().isNotEmpty;
                });
              },
              onSubmitted: (_) {
                if (_isComposing) _handleSubmitted();
              },
              style: GoogleFonts.poppins(
                color: isDarkMode
                    ? AppTheme.darkTextColor
                    : AppTheme.lightTextColor,
              ),
              decoration: InputDecoration(
                hintText: 'Mesajınızı yazın...',
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(
                  color: isDarkMode
                      ? AppTheme.darkTextColor.withOpacity(0.5)
                      : Colors.grey[400],
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: _isComposing
                ? AppTheme.primaryColor
                : (isDarkMode ? Colors.grey[600] : Colors.grey[400]),
            onPressed: _isComposing ? _handleSubmitted : null,
          ),
        ],
      ),
    );
  }
}
