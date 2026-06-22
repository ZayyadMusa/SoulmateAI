import 'package:hive/hive.dart';

part 'memory.g.dart';

@HiveType(typeId: 1)
class Memory extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final List<String> tags;

  @HiveField(5)
  final bool isFavorite;

  Memory({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.tags = const [],
    this.isFavorite = false,
  });
}
