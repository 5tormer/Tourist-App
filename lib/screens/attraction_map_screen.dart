import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tourist_app/models/attraction.dart';
import 'package:tourist_app/services/attraction_map_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController _yandexMapController;
  final PanelController _panelController = PanelController();
  List<MapObject> _mapObjects = [];
  List<Attraction> _listOfAttractions = [];
  String _currentAttractionName = '';
  String _currentAttractionImageLink = '';
  String _currentAttractionDescription = '';

  @override
  void initState() {
    AttractionMapService().getHacks().then((listOfAttractions) {
      _listOfAttractions = listOfAttractions;
      _mapObjects = listOfAttractions
          .map(
            (attraction) => PlacemarkMapObject(
              mapId: MapObjectId(
                attraction.sightName!,
              ),
              point: Point(
                latitude: attraction.cords!.lat!,
                longitude: attraction.cords!.long!,
              ),
              onTap: (placemark, point) async {
                setState(() {
                  var _selectedAttraction = _listOfAttractions.firstWhere(
                      (element) =>
                          MapObjectId(element.sightName!) == placemark.mapId);
                  setUpAllFields(_selectedAttraction);
                });
                if (_panelController.isPanelOpen) {
                  await _panelController.close();
                  await _openPanel();
                }
                await _openPanel();
              },
            ),
          )
          .toList();
      setState(() {});
    });
    super.initState();
  }

  void setUpAllFields(Attraction selectedAttraction) {
    setState(() {
      _currentAttractionName = selectedAttraction.sightName!;
      _currentAttractionImageLink = selectedAttraction.image!;
      _currentAttractionDescription = selectedAttraction.description!;
    });
  }

  Future<void> _openPanel() async {
    await _panelController.animatePanelToPosition(0.6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: 600,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        controller: _panelController,
        minHeight: 0,
        panel: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _currentAttractionName,
                style: const TextStyle(fontSize: 22),
              ),
            ),
            Image.network(
              _currentAttractionImageLink,
              errorBuilder: ((_, __, ___) => const SizedBox.shrink()),
              loadingBuilder: ((_, child, progress) {
                if (progress == null) return child;
                return const CircularProgressIndicator();
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                _currentAttractionDescription,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        body: YandexMap(
          mapObjects: _mapObjects,
          onMapCreated: (controller) async {
            _yandexMapController = controller;
          },
        ),
      ),
    );
  }
}
