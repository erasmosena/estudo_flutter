import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import '../models/terremoto.dart';


const baseUrl = "https://earthquake.usgs.gov";

class API {
  static Future<Terremoto> getTerremotos() async{
    var url = baseUrl + "/earthquakes/feed/v1.0/summary/all_day.geojson";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Terremoto.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

}
