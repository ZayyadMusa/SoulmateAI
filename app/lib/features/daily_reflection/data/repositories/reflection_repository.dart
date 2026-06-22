import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/reflection.dart';

part 'reflection_repository.g.dart';

class ReflectionRepository {
  static const String boxName = 'reflections';
  late Box<Reflection> _box;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ReflectionAdapter());
    }
    _box = await Hive.openBox<Reflection>(boxName);
  }

  Future<void> saveReflection(Reflection reflection) async {
    await _box.put(reflection.id, reflection);
  }

  List<Reflection> getAllReflections() {
    return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }
}

@riverpod
ReflectionRepository reflectionRepository(ReflectionRepositoryRef ref) {
  return ReflectionRepository();
}
