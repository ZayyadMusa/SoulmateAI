import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/dream.dart';
import '../../data/repositories/dream_repository.dart';

part 'nocturnal_controller.g.dart';

class NocturnalState {
  final bool isPlayingSound;
  final String activeSoundTrack;
  final List<Dream> dreams;

  NocturnalState({
    this.isPlayingSound = false,
    this.activeSoundTrack = 'None',
    this.dreams = const [],
  });

  NocturnalState copyWith({
    bool? isPlayingSound,
    String? activeSoundTrack,
    List<Dream>? dreams,
  }) {
    return NocturnalState(
      isPlayingSound: isPlayingSound ?? this.isPlayingSound,
      activeSoundTrack: activeSoundTrack ?? this.activeSoundTrack,
      dreams: dreams ?? this.dreams,
    );
  }
}

@riverpod
class NocturnalController extends _$NocturnalController {
  @override
  FutureOr<NocturnalState> build() async {
    final repository = ref.watch(dreamRepositoryProvider);
    await repository.init();
    return NocturnalState(dreams: repository.getAllDreams());
  }

  void toggleSound(String track) {
    if (state.value?.activeSoundTrack == track && state.value?.isPlayingSound == true) {
      state = AsyncData(state.value!.copyWith(isPlayingSound: false));
    } else {
      state = AsyncData(state.value!.copyWith(isPlayingSound: true, activeSoundTrack: track));
    }
  }

  Future<void> addDream(String content) async {
    final repository = ref.read(dreamRepositoryProvider);
    final newDream = Dream(
      id: DateTime.now().toIso8601String(),
      date: DateTime.now(),
      content: content,
    );
    
    await repository.saveDream(newDream);
    
    state = AsyncData(state.value!.copyWith(dreams: repository.getAllDreams()));
  }
}
