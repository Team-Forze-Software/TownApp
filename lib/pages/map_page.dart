import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:town_app/models/poi.dart';

class MapPage extends StatefulWidget {
  final POI poi;
  const MapPage({Key? key, required this.poi}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("'${widget.poi.name}' en mapa"),),
      body: FlutterMap(
        mapController: MapController(),
        options: MapOptions(
          center: LatLng(widget.poi.location.latitude, widget.poi.location.longitude),
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          maxZoom: 18.0,
          zoom: 12.0
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: "com.team_forze.town_app",
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(widget.poi.location.latitude, widget.poi.location.longitude),
                anchorPos: AnchorPos.align(AnchorAlign.top,),
                width: 300,
                height: 150,
                builder: (context) => Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Image.network(widget.poi.photoUrl, height: 80, width: 200, fit: BoxFit.cover, alignment: Alignment.center),
                          const SizedBox(height: 10,),
                          Text(widget.poi.name, style: const TextStyle(fontSize: 12),),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                    const Icon(Icons.location_on, color: Colors.red,),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
