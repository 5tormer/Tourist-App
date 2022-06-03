import 'package:tourist_app/models/cords.dart';

class Attraction {
  String? sightName;
  String? image;
  String? description;
  Cords? cords;

  Attraction({this.sightName, this.image, this.description, this.cords});

  Attraction.fromJson(Map<String, dynamic> json) {
    sightName = json['sightName'];
    image = json['image'];
    description = json['description'];
    cords = json['cords'] != null ? Cords.fromJson(json['cords']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sightName'] = sightName;
    data['image'] = image;
    data['description'] = description;
    if (cords != null) {
      data['cords'] = cords!.toJson();
    }
    return data;
  }
}
