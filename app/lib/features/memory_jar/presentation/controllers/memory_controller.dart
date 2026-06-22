import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/memory.dart';
import '../../data/repositories/memory_repository.dart';

part 'memory_controller.g.dart';

@riverpod
class MemoryController extends _$MemoryController {
  @override
  FutureOr<List<Memory>> build() async {
    final repository = ref.watch(memoryRepositoryProvider);
    await repository.init();
    return repository.getAllMemories();
  }

  void search(String query) {
    final repository = ref.read(memoryRepositoryProvider);
    state = AsyncData(repository.searchMemories(query));
  }

  Future<void> addMemory(String title, String description, List<String> tags) async {
    final repository = ref.read(memoryRepositoryProvider);
    final newMemory = Memory(
      id: DateTime.now().toIso8601String(),
      title: title,
      description: description,
      date: DateTime.now(),
      tags: tags,
    );
    
    await repository.saveMemory(newMemory);
    
    state = AsyncData(repository.getAllMemories());
  }
}
