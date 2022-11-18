import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  void addPOIToFavorites(POI poi) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection("users").doc(userUid).get();
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      List<dynamic> favorites = userData["favorites"] ?? [];
      if (!favorites.contains(poi.id)) {
        favorites.add(poi.id);
        setState(() {
          favoriteIcon = Icons.favorite;
        });
      } else {
        favorites.remove(poi.id);
        setState(() {
          favoriteIcon = Icons.favorite_border;
        });
      }
      userData["favorites"] = favorites;
      await FirebaseFirestore.instance.collection("users").doc(userUid).update(userData);
    } on FirebaseException catch (e) {
      print("Error saving favorite: ${e.code}");
    }
  }

  void setFavoriteIcon(String id) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      var userData = await FirebaseFirestore.instance.collection("users").doc(userId).get();
      List<dynamic> favorites = userData.data()!["favorites"] ?? [];
      if (favorites.contains(id)) {
        setState(() {
          favoriteIcon = Icons.favorite;
        });
      } else {
        setState(() {
          favoriteIcon = Icons.favorite_border;
        });
      }
    } catch (e, s) {
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String document = widget.documentId;
    return Scaffold(
      appBar: AppBar(
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
              setFavoriteIcon(snapshot.data!.id);
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
