import 'package:cloud_firestore/cloud_firestore.dart';

class POI {
  String id = "";
  String name = "Sin nombre";
  String description = "";
  String photoUrl = "";
  int punctuation = 0;
  GeoPoint location = const GeoPoint(0, 0);

  POI(this.name, this.description, this.photoUrl, this.punctuation, this.location);

  POI.fromJson(Map<String, dynamic> data) {
    name = data["name"];
    description = data["description"];
    photoUrl = data["photo_url"];
    punctuation = data["punctuation"];
    location = GeoPoint(data["location"].latitude, data["location"].longitude);
  }
}