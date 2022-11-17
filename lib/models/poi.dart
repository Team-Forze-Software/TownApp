class POI {
  String id = "";
  String name = "Sin nombre";
  String description = "";
  String photoUrl = "";
  int punctuation = 0;

  POI(this.name, this.description, this.photoUrl, this.punctuation);

  POI.fromJson(Map<String, dynamic> data) {
    name = data["name"];
    description = data["description"];
    photoUrl = data["photo_url"];
    punctuation = data["punctuation"];
  }
}