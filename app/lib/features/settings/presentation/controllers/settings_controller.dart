import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

class SettingsState {
  final bool dailyReflections;
  final bool morningRituals;
  final bool voiceMessages;
  final bool weeklySummaries;
  final bool gentleChimes;

  SettingsState({
    this.dailyReflections = true,
    this.morningRituals = true,
    this.voiceMessages = false,
    this.weeklySummaries = true,
    this.gentleChimes = true,
  });

  SettingsState copyWith({
    bool? dailyReflections,
    bool? morningRituals,
    bool? voiceMessages,
    bool? weeklySummaries,
    bool? gentleChimes,
  }) {
    return SettingsState(
      dailyReflections: dailyReflections ?? this.dailyReflections,
      morningRituals: morningRituals ?? this.morningRituals,
      voiceMessages: voiceMessages ?? this.voiceMessages,
      weeklySummaries: weeklySummaries ?? this.weeklySummaries,
      gentleChimes: gentleChimes ?? this.gentleChimes,
    );
  }
}

@riverpod
class SettingsController extends _$SettingsController {
  late Box _box;

  @override
  SettingsState build() {
    _box = Hive.box('settings');
    return SettingsState(
      dailyReflections: _box.get('dailyReflections', defaultValue: true),
      morningRituals: _box.get('morningRituals', defaultValue: true),
      voiceMessages: _box.get('voiceMessages', defaultValue: false),
      weeklySummaries: _box.get('weeklySummaries', defaultValue: true),
      gentleChimes: _box.get('gentleChimes', defaultValue: true),
    );
  }

  void updateSettings(SettingsState newState) {
    _box.put('dailyReflections', newState.dailyReflections);
    _box.put('morningRituals', newState.morningRituals);
    _box.put('voiceMessages', newState.voiceMessages);
    _box.put('weeklySummaries', newState.weeklySummaries);
    _box.put('gentleChimes', newState.gentleChimes);
    state = newState;
  }
}
