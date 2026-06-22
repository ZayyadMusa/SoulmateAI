import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/reflection.dart';
import '../../data/repositories/reflection_repository.dart';

part 'reflection_controller.g.dart';

@riverpod
class ReflectionController extends _$ReflectionController {
  @override
  FutureOr<List<Reflection>> build() async {
    final repository = ref.watch(reflectionRepositoryProvider);
    await repository.init();
    return repository.getAllReflections();
  }

  Future<void> addReflection(String mood, String content) async {
    final repository = ref.read(reflectionRepositoryProvider);
    final newReflection = Reflection(
      id: DateTime.now().toIso8601String(),
      date: DateTime.now(),
      mood: mood,
      content: content,
    );
    
    await repository.saveReflection(newReflection);
    
    // Update state
    state = AsyncData([newReflection, ...state.value ?? []]);
  }
}
