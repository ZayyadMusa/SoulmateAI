import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/memory.dart';

part 'memory_repository.g.dart';

class MemoryRepository {
  static const String boxName = 'memories';
  late Box<Memory> _box;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MemoryAdapter());
    }
    _box = await Hive.openBox<Memory>(boxName);
  }

  Future<void> saveMemory(Memory memory) async {
    await _box.put(memory.id, memory);
  }

  List<Memory> getAllMemories() {
    return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }
  
  List<Memory> searchMemories(String query) {
    if (query.isEmpty) return getAllMemories();
    final lowerQuery = query.toLowerCase();
    return _box.values.where((m) {
      return m.title.toLowerCase().contains(lowerQuery) ||
             m.description.toLowerCase().contains(lowerQuery) ||
             m.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList()..sort((a, b) => b.date.compareTo(a.date));
  }
}

@riverpod
MemoryRepository memoryRepository(MemoryRepositoryRef ref) {
  return MemoryRepository();
}
