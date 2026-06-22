import 'package:hive/hive.dart';

part 'reflection.g.dart';

@HiveType(typeId: 0)
class Reflection extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String mood;

  @HiveField(3)
  final String content;

  Reflection({
    required this.id,
    required this.date,
    required this.mood,
    required this.content,
  });
}
