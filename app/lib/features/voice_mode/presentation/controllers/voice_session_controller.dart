import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

part 'voice_session_controller.g.dart';

enum SessionState { idle, listening, processing, speaking }

@riverpod
class VoiceSessionController extends _$VoiceSessionController {
  Timer? _timer;

  @override
  SessionState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return SessionState.idle;
  }

  void startListening() {
    state = SessionState.listening;
    // Mock processing after 3 seconds
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), () {
      state = SessionState.processing;
      
      // Mock speaking after 1.5 seconds of processing
      _timer = Timer(const Duration(milliseconds: 1500), () {
        state = SessionState.speaking;
        
        // Mock back to idle after 4 seconds of speaking
        _timer = Timer(const Duration(seconds: 4), () {
          state = SessionState.idle;
        });
      });
    });
  }

  void stop() {
    _timer?.cancel();
    state = SessionState.idle;
  }
}
