import 'package:hive_flutter/hive_flutter.dart';
import 'package:town_app/models/local_poi.dart';

class HiveBoxes {
  static Box<LocalPOI> getFavoritesBox() => Hive.box<LocalPOI>('favorites');
}
