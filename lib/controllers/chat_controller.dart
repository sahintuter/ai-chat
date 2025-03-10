import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/chat_message.dart';
import '../services/gemini_service.dart';
import '../controllers/profile_controller.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxList<Chat> allChats = <Chat>[].obs; // Tüm sohbetler
  final RxBool isLoading = false.obs;
  final GeminiService _geminiService = GeminiService();
  Map<String, dynamic>? currentCharacter;

  @override
  void onInit() {
    super.onInit();
    loadChatsFromCache();
  }

  void startNewChat(Map<String, dynamic> character) {
    // Karakter adını al
    final characterName = character['name'] as String;

    // Mevcut karakteri güncelle
    currentCharacter = character;

    // Bu karakterle daha önce sohbet var mı kontrol et
    final existingChatIndex =
        allChats.indexWhere((chat) => chat.character['name'] == characterName);

    if (existingChatIndex != -1) {
      // Var olan sohbeti yükle
      loadExistingChat(characterName);
    } else {
      // Yeni sohbet başlat
      messages.clear();
      final newChat = Chat(
        character: character,
        lastMessage: null,
        messages: [],
      );
      allChats.insert(0, newChat); // Yeni sohbeti listenin başına ekle
      debugPrint('Yeni sohbet başlatıldı: $characterName');
    }

    // Değişiklikleri kaydet
    saveChatsToCache();
  }

  void loadExistingChat(String characterName) {
    final existingChatIndex =
        allChats.indexWhere((chat) => chat.character['name'] == characterName);

    if (existingChatIndex != -1) {
      // Var olan sohbeti yükle
      messages.clear();
      messages.assignAll(allChats[existingChatIndex].messages);

      // Sohbeti listenin başına taşı
      final chat = allChats.removeAt(existingChatIndex);
      allChats.insert(0, chat);

      debugPrint(
          'Var olan sohbet yüklendi: $characterName, ${chat.messages.length} mesaj');
    }
  }

  Future<void> loadChatsFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedChats = prefs.getStringList('cached_chats') ?? [];

      for (final chatJson in cachedChats) {
        final chatData = jsonDecode(chatJson);
        final chat = Chat(
          character: chatData['character'],
          lastMessage: chatData['lastMessage'],
          messages: (chatData['messages'] as List)
              .map((m) => ChatMessage.fromJson(m))
              .toList(),
        );
        allChats.add(chat);
      }
    } catch (e) {
      debugPrint('Cache yüklenirken hata: $e');
    }
  }

  Future<void> saveChatsToCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> chatJsonList = allChats.map((chat) {
        return jsonEncode({
          'character': chat.character,
          'lastMessage': chat.lastMessage,
          'messages': chat.messages.map((m) => m.toJson()).toList(),
        });
      }).toList();

      await prefs.setStringList('cached_chats', chatJsonList);
    } catch (e) {
      debugPrint('Cache kaydedilirken hata: $e');
    }
  }

  void updateLastMessage(String message) {
    if (currentCharacter == null) return;

    final characterName = currentCharacter!['name'] as String;
    final existingChatIndex =
        allChats.indexWhere((chat) => chat.character['name'] == characterName);

    if (existingChatIndex != -1) {
      // Mevcut sohbeti güncelle
      final existingChat = allChats[existingChatIndex];

      // Sohbeti güncelle
      allChats[existingChatIndex] = Chat(
        character: existingChat.character,
        lastMessage: message,
        messages: List.from(messages), // Güncel mesajların kopyasını al
      );

      // Sohbeti listenin başına taşı
      if (existingChatIndex != 0) {
        final chat = allChats.removeAt(existingChatIndex);
        allChats.insert(0, chat);
      }

      // Cache'i güncelle
      saveChatsToCache();
      debugPrint(
          'Sohbet güncellendi: $characterName, ${messages.length} mesaj');
    }
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty || currentCharacter == null) return;

    final profileController = Get.find<ProfileController>();
    if (!profileController.canUseTokens(1)) {
      Get.snackbar(
        'Token Yetersiz',
        'Mesaj göndermek için yeterli tokeniniz yok',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Kullanıcı mesajını ekle
      final userMessage = ChatMessage(
        text: message,
        isUser: true,
        timestamp: DateTime.now(),
      );
      messages.insert(0, userMessage);
      updateLastMessage(message);

      // AI yanıtını al
      final response = await _geminiService.getResponse(message);

      // AI yanıtını ekle
      final aiMessage = ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      );
      messages.insert(0, aiMessage);
      updateLastMessage(response);

      // Token düş
      profileController.useTokens(1);
    } catch (e) {
      debugPrint('Hata: $e');
      Get.snackbar('Hata', 'Mesaj gönderilemedi');
    } finally {
      isLoading.value = false;
    }
  }

  void clearChat() {
    messages.clear();
  }

  Future<void> clearAllChats() async {
    try {
      // Belleği temizle
      allChats.clear();
      messages.clear();
      currentCharacter = null;

      // Cache'i temizle
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('cached_chats');

      Get.snackbar(
        'Başarılı',
        'Tüm sohbet geçmişi temizlendi',
        snackPosition: SnackPosition.BOTTOM,
      );

      debugPrint('Tüm cache temizlendi');
    } catch (e) {
      debugPrint('Cache temizlenirken hata: $e');
      Get.snackbar(
        'Hata',
        'Sohbet geçmişi temizlenirken bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    messages.clear();
    super.onClose();
  }
}

// Chat model sınıfı
class Chat {
  final Map<String, dynamic> character;
  String? lastMessage;
  List<ChatMessage> messages;

  Chat({
    required this.character,
    this.lastMessage,
    required this.messages,
  });
}
