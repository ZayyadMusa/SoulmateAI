import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/dream.dart';

part 'dream_repository.g.dart';

class DreamRepository {
  static const String boxName = 'dreams';
  late Box<Dream> _box;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(DreamAdapter());
    }
    _box = await Hive.openBox<Dream>(boxName);
  }

  Future<void> saveDream(Dream dream) async {
    await _box.put(dream.id, dream);
  }

  List<Dream> getAllDreams() {
    return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }
}

@riverpod
DreamRepository dreamRepository(DreamRepositoryRef ref) {
  return DreamRepository();
}
