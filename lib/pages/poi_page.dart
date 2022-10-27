import 'package:flutter/material.dart';

class POIPage extends StatefulWidget {
  const POIPage({Key? key}) : super(key: key);

  @override
  State<POIPage> createState() => _POIPageState();
}

class _POIPageState extends State<POIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle Sitio Turístico POI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Nombre POI',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(
                    "https://via.placeholder.com/200?text=Placeholder",
                    height: 300,
                    width: 300,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Ciudad: XXXXXX'),
                  Text('Departamento: XXXXXX'),
                  Text('Temperatura: XX'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Descripción: Sed ut perspiciatus, unde omnis iste natus error "
                    "sit voluptatem accusant doloremque laudantium, totam "
                    "rem apreiam eaque ipsa, quae ab itlo inventore veritatis."
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Otra información de interés."),
                ]
            )
          ],
        ),
      ),
    );
  }
}
