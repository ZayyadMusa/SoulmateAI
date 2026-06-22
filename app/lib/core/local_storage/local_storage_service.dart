import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // We will register adapters and open boxes here as we build features.
    // e.g. await Hive.openBox('daily_reflections');
  }
}
