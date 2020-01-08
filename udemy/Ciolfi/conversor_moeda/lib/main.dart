import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';

import 'home.dart';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=2db59ac6";

void main()async{

  
  print(await getData());
  runApp(
    MaterialApp(
      title: 'Conversor',
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
      ),
      home: Home(),
    )
  );
}

Future<Map> getData()async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}