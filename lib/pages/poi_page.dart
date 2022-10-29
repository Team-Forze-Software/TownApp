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
                children: const [
                  Text(
                    'Cerro Cristo Rey',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image(image: AssetImage("assets/images/cristoret.PNG")),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Ciudad: Ciudad Bolivar'),
                  Text('Departamento: Antioquia'),
                  Text('Temperatura: 16°C - 24°C'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Es un mirador importante del Ciudad Bolívar. Tiene en su extensión senderos de adoquines, teatro al aire libre, "
                          "plataformas para vuelo de cometas y un cristo redentor en su cima. es de fácil acceso para todo tipo de publico"

                  "Dirección: Ubicado al costado norte del parque principal Simón Bolívar."
                  ),
                  SizedBox(
                    height: 10,
                  ),

                ]
            )
          ],
        ),
      ),
    );
  }
}
