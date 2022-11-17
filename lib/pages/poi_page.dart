import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:town_app/hive_boxes.dart';
import 'package:town_app/models/local_poi.dart';
import 'package:town_app/models/poi.dart';

class POIPage extends StatefulWidget {
  final String documentId;

  const POIPage({Key? key, required this.documentId}) : super(key: key);

  @override
  State<POIPage> createState() => _POIPageState();
}

class _POIPageState extends State<POIPage> {
  CollectionReference poiCollection = FirebaseFirestore.instance.collection("points_of_interest");
  IconData favoriteIcon = Icons.favorite_border;

  void addPOIToFavorites(POI poi) {
    if (HiveBoxes.getFavoritesBox().containsKey(poi.id)) {
      HiveBoxes.getFavoritesBox().delete(poi.id);
      setState(() {
        favoriteIcon = Icons.favorite_border;
      });
    } else {
      final localPoi = LocalPOI()
        ..id = poi.id
        ..name = poi.name
        ..description = poi.description
        ..photoUrl = poi.photoUrl
        ..punctuation = poi.punctuation;
      HiveBoxes.getFavoritesBox().put(poi.id, localPoi);
      setState(() {
        favoriteIcon = Icons.favorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String document = widget.documentId;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Retroceder",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Detalle Sitio Turístico POI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: poiCollection.doc(document).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error = ${snapshot.error}");
            }

            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data?.data() as Map<String, dynamic>;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data["name"],
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        POI loadedPoi = POI.fromJson(data);
                        loadedPoi.id = snapshot.data?.id ?? "";
                        addPOIToFavorites(loadedPoi);
                      },
                      icon: Icon(favoriteIcon, color: Colors.redAccent,),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 300,
                      child: Image.network(
                        data["photo_url"], fit: BoxFit.cover,),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(data["description"]),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Puntuación: ${"⭐" * data["punctuation"]}"),
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
