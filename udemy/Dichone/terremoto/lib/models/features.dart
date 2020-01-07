import 'package:terremoto/models/properties.dart';

import 'geometry.dart';

class Feature{
  String type;
  Properties properties;
  Geometry geometry;
  String id;

  Feature.fromJson(Map json)
      : type = json['type'],
        properties = Properties.fromJson(json['properties']),
        geometry = Geometry.fromJson(json['geometry']),
        id = json['id'];

  Map toJson() {
    return {'type': type, 'properties': properties, 'geometry': geometry, 'id':id};
  }

}