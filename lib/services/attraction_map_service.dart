import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tourist_app/models/attraction.dart';

class AttractionMapService {
  Future<List<Attraction>> getAttraction() async {
    var data = await rootBundle.loadString('assets/data.json');
    var body = json.decode(data) as List<dynamic>;
    return body
        .map((model) => Attraction.fromJson(model as Map<String, dynamic>))
        .toList();
  }
}
