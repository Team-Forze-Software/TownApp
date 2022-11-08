import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:town_app/pages/poi_list.dart';

class POIPage extends StatefulWidget {
  final String documentId;
  const POIPage({Key? key, required this.documentId}) : super(key: key);

  @override
  State<POIPage> createState() => _POIPageState();
}

class _POIPageState extends State<POIPage> {
  CollectionReference poiCollection =
      FirebaseFirestore.instance.collection("points_of_interest");

  @override
  Widget build(BuildContext context) {
    final String document = widget.documentId;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Retroceder",
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const POIList()));
          },
        ),
        title: const Text('Detalle Sitio Turístico POI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: poiCollection.doc(document).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {return Text("Error = ${snapshot.error}");}

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
