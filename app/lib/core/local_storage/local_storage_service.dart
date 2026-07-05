import 'package:hive_flutter/hive_flutter.dart';

import '../../features/daily_reflection/domain/models/reflection.dart';
import '../../features/memory_jar/domain/models/memory.dart';
import '../../features/supportive_chat/domain/models/chat_message.dart';
import '../../features/voice_mode/domain/models/voice_profile.dart';
import '../../features/nocturnal_mode/domain/models/dream.dart';

class LocalStorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register Adapters
    Hive.registerAdapter(ReflectionAdapter());
    Hive.registerAdapter(MemoryAdapter());
    Hive.registerAdapter(ChatMessageAdapter());
    Hive.registerAdapter(VoiceProfileAdapter());
    Hive.registerAdapter(DreamAdapter());
    
    // Open Boxes
    await Hive.openBox<Reflection>('reflections');
    await Hive.openBox<Memory>('memories');
    await Hive.openBox<ChatMessage>('chat_messages');
    await Hive.openBox<VoiceProfile>('voice_profiles');
    await Hive.openBox<Dream>('dreams');
    await Hive.openBox('settings');
    await Hive.openBox('profile');
  }
}
