import 'package:hive_flutter/hive_flutter.dart';

import '../../features/daily_reflection/domain/models/reflection.dart';
import '../../features/memory_jar/domain/models/memory.dart';

class LocalStorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register Adapters
    Hive.registerAdapter(ReflectionAdapter());
    Hive.registerAdapter(MemoryAdapter());
    
    // Open Boxes
    await Hive.openBox<Reflection>('reflections');
    await Hive.openBox<Memory>('memories');
  }
}
