import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:town_app/models/poi.dart';
import 'package:town_app/pages/poi_page.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: _buildListView()),
      ),
    );
  }

  Future<List<POI>> getFavorites() async {
    CollectionReference poiCollection = FirebaseFirestore.instance.collection("points_of_interest");
    final user = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid ?? "").get();
    List<dynamic> userFavorites = user.get("favorites") as List<dynamic>;
    List<POI> favorites = [];

    QuerySnapshot<Object?> points = await poiCollection.get();
    for (var element in points.docs) {
      if (element.exists) {
        if (userFavorites.contains(element.id)) {
          POI favPOI = POI.fromJson(element.data() as Map<String, dynamic>);
          favPOI.id = element.id;
          favorites.add(favPOI);
        }
      }
    }

    return favorites;
  }

  Widget _buildListView() {
    return FutureBuilder(
      future: getFavorites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final POI poi = snapshot.data!.elementAt(index);
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(poi.photoUrl ?? ""),
                    ),
                    title: Text(poi.name ?? "Sin titulo"),
                    onTap: () {
                      setState(() async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => POIPage(documentId: poi.id ?? ""),
                            )
                        ).then(onGoBackFromPoiPage);
                      });
                    },
                  ),
                );
              },
            );
          } else {
            return const Text("No hay datos");
          }
        } else {
          return const CircularProgressIndicator();
        }

      },
    );
  }

  void onGoBackFromPoiPage(dynamic value) {
    setState(() {});
  }
}
