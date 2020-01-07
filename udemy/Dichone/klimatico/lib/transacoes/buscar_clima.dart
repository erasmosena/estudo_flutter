import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String urlBase = 'http://api.openweathermap.org/data/2.5/weather';

Future<Map> buscarClima(String apikey, String cidade ) async {
  String url = '$urlBase?q=$cidade&appid=$apikey&units=metric';

  http.Response response = await http.get(url);

  if(response.statusCode == 200 ){
    return json.decode(response.body);
  }else{
    debugPrint("falha na requisição: $url");
  }
}