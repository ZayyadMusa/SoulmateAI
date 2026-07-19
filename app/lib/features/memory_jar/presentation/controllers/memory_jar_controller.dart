import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/memory.dart';

part 'memory_jar_controller.g.dart';

@riverpod
class MemoryJarController extends _$MemoryJarController {
  late Box<Memory> _box;

  @override
  FutureOr<List<Memory>> build() async {
    _box = Hive.box<Memory>('memories');
    return _box.values.toList();
  }

  Future<void> addMemory(Memory memory) async {
    await _box.put(memory.id, memory);
    state = AsyncData(_box.values.toList());
  }

  Future<void> deleteMemory(String id) async {
    await _box.delete(id);
    state = AsyncData(_box.values.toList());
  }
}
