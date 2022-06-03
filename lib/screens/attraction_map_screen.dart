import 'package:flutter/material.dart';
import 'package:tourist_app/services/attraction_map_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController _yandexMapController;
  List<MapObject> _mapObjects = [];

  @override
  void initState() {
    AttractionMapService().getHacks().then((value) {
      _mapObjects = value
          .map(
            (attraction) => PlacemarkMapObject(
              mapId: MapObjectId(
                value.indexOf(attraction).toString(),
              ),
              point: Point(
                latitude: attraction.cords!.lat!,
                longitude: attraction.cords!.long!,
              ),
              onTap: (placemark, point) {},
            ),
          )
          .toList();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        mapObjects: _mapObjects,
        onMapCreated: (controller) async {
          _yandexMapController = controller;
        },
      ),
    );
  }
}
