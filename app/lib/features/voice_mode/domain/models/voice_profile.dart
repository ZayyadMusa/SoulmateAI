import 'package:hive/hive.dart';

part 'voice_profile.g.dart';

@HiveType(typeId: 2)
class VoiceProfile extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final bool isSelected;

  VoiceProfile({
    required this.id,
    required this.name,
    required this.description,
    this.isSelected = false,
  });
}
