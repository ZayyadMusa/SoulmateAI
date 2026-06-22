import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/chat_message.dart';

part 'chat_repository.g.dart';

class ChatRepository {
  static const String boxName = 'chat_messages';
  late Box<ChatMessage> _box;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(ChatMessageAdapter());
    }
    _box = await Hive.openBox<ChatMessage>(boxName);
  }

  Future<void> saveMessage(ChatMessage message) async {
    await _box.put(message.id, message);
  }

  List<ChatMessage> getMessages() {
    return _box.values.toList()..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
}

@riverpod
ChatRepository chatRepository(ChatRepositoryRef ref) {
  return ChatRepository();
}
