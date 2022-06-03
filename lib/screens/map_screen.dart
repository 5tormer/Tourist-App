import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController _yandexMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        // mapObjects: viewModel.mapObjects,
        onMapCreated: (controller) async {
          _yandexMapController = controller;
        },
      ),
    );
  }
}
