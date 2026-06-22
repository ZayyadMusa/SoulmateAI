import 'package:hive/hive.dart';

part 'dream.g.dart';

@HiveType(typeId: 3)
class Dream extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String content;

  Dream({
    required this.id,
    required this.date,
    required this.content,
  });
}
