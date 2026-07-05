import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

class ProfileState {
  final String name;

  ProfileState({this.name = ''});
}

@riverpod
class ProfileController extends _$ProfileController {
  late Box _box;

  @override
  ProfileState build() {
    _box = Hive.box('profile');
    return ProfileState(
      name: _box.get('name', defaultValue: ''),
    );
  }

  void updateName(String name) {
    _box.put('name', name);
    state = ProfileState(name: name);
  }
}
