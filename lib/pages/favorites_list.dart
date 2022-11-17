import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:town_app/hive_boxes.dart';
import 'package:town_app/pages/poi_page.dart';

import '../models/local_poi.dart';

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

  Widget _buildListView() {
    return ValueListenableBuilder<Box<LocalPOI>>(
      valueListenable: HiveBoxes.getFavoritesBox().listenable(),
      builder: (context, box, child) {
        final poiBox = box.values.toList().cast<LocalPOI>();
        if (poiBox.isNotEmpty) {
          return ListView.builder(
            itemCount: poiBox.length,
            itemBuilder: (context, index) {
              final poi = poiBox[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      poi.photoUrl ?? "",
                    ),
                  ),
                  title: Text(poi.name ?? "Sin nombre"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                POIPage(documentId: poi.id ?? "")
                        )
                    );
                  },
                ),
              );
            },
          );
        } else {
          return const Text("No hay favoritos");
        }
      },
    );
  }
}
