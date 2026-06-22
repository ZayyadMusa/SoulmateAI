import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/chat_message.dart';
import '../../data/repositories/chat_repository.dart';
import 'dart:async';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  FutureOr<List<ChatMessage>> build() async {
    final repository = ref.watch(chatRepositoryProvider);
    await repository.init();
    
    final messages = repository.getMessages();
    if (messages.isEmpty) {
      final welcomeMessage = ChatMessage(
        id: DateTime.now().toIso8601String(),
        text: "Hello! I'm here to listen without judgment. What's on your mind?",
        isUser: false,
        timestamp: DateTime.now(),
      );
      await repository.saveMessage(welcomeMessage);
      return [welcomeMessage];
    }
    return messages;
  }

  Future<void> sendMessage(String text) async {
    final repository = ref.read(chatRepositoryProvider);
    
    final userMsg = ChatMessage(
      id: DateTime.now().toIso8601String(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
    await repository.saveMessage(userMsg);
    state = AsyncData(repository.getMessages());

    // Mock companion response to simulate empathy and support
    Timer(const Duration(seconds: 2), () async {
      final responseMsg = ChatMessage(
        id: DateTime.now().toIso8601String(),
        text: "I understand. That sounds challenging. If you need, I can help you draft a response or an email.",
        isUser: false,
        timestamp: DateTime.now(),
      );
      await repository.saveMessage(responseMsg);
      state = AsyncData(repository.getMessages());
    });
  }
}
