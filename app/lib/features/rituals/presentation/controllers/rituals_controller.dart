import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rituals_controller.g.dart';

class RitualsState {
  final bool drinkWaterDone;
  final bool dailyStretchDone;

  RitualsState({
    this.drinkWaterDone = false,
    this.dailyStretchDone = false,
  });

  RitualsState copyWith({
    bool? drinkWaterDone,
    bool? dailyStretchDone,
  }) {
    return RitualsState(
      drinkWaterDone: drinkWaterDone ?? this.drinkWaterDone,
      dailyStretchDone: dailyStretchDone ?? this.dailyStretchDone,
    );
  }
}

@riverpod
class RitualsController extends _$RitualsController {
  late Box _box;

  @override
  RitualsState build() {
    _box = Hive.box('rituals');
    return RitualsState(
      drinkWaterDone: _box.get('drinkWaterDone', defaultValue: false),
      dailyStretchDone: _box.get('dailyStretchDone', defaultValue: false),
    );
  }

  void toggleDrinkWater() {
    final newValue = !state.drinkWaterDone;
    _box.put('drinkWaterDone', newValue);
    state = state.copyWith(drinkWaterDone: newValue);
  }

  void toggleDailyStretch() {
    final newValue = !state.dailyStretchDone;
    _box.put('dailyStretchDone', newValue);
    state = state.copyWith(dailyStretchDone: newValue);
  }
}
