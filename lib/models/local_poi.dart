import 'package:hive/hive.dart';

part 'local_poi.g.dart';

@HiveType(typeId: 0)
class LocalPOI extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? photoUrl;

  @HiveField(4)
  int? punctuation;
}
