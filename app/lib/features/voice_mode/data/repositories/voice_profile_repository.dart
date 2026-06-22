import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/voice_profile.dart';

part 'voice_profile_repository.g.dart';

class VoiceProfileRepository {
  static const String boxName = 'voice_profiles';
  late Box<VoiceProfile> _box;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(VoiceProfileAdapter());
    }
    _box = await Hive.openBox<VoiceProfile>(boxName);
    
    // Seed default profiles if empty
    if (_box.isEmpty) {
      await _box.put('1', VoiceProfile(id: '1', name: 'Aura', description: 'Warm, calm, and deeply empathetic.', isSelected: true));
      await _box.put('2', VoiceProfile(id: '2', name: 'Echo', description: 'Clear, direct, and slightly energetic.'));
      await _box.put('3', VoiceProfile(id: '3', name: 'Sage', description: 'Low, resonant, and grounded.'));
    }
  }

  List<VoiceProfile> getAllProfiles() {
    return _box.values.toList();
  }

  Future<void> selectProfile(String id) async {
    for (var profile in _box.values) {
      final updated = VoiceProfile(
        id: profile.id,
        name: profile.name,
        description: profile.description,
        isSelected: profile.id == id,
      );
      await _box.put(profile.id, updated);
    }
  }
}

@riverpod
VoiceProfileRepository voiceProfileRepository(VoiceProfileRepositoryRef ref) {
  return VoiceProfileRepository();
}
