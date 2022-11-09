import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:town_app/pages/poi_page.dart';

import 'login_page.dart';

class POIList extends StatefulWidget {
  const POIList({Key? key}) : super(key: key);

  @override
  State<POIList> createState() => _POIListState();
}

enum Menu { logOut }

class _POIListState extends State<POIList> {
  CollectionReference poiData =
      FirebaseFirestore.instance.collection("points_of_interest");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Puntos de Interés"),
        actions: [
          PopupMenuButton(
            onSelected: (Menu item) {
              setState(() {
                if (item == Menu.logOut) {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }
              });
            },
            itemBuilder: (context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem(
                value: Menu.logOut,
                child: Text("Cerrar sesión"),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: poiData.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => POIPage(
                              documentId:
                                  snapshot.data!.docs.elementAt(index).id)),
                    ),
                    title:
                        Text(snapshot.data?.docs.elementAt(index).get("name")),
                    subtitle: Text(
                      snapshot.data?.docs.elementAt(index).get("description"),
                      maxLines: 2,
                    ),
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        snapshot.data?.docs.elementAt(index).get("photo_url"),
                        scale: 1,
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
