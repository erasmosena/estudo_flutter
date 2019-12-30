import 'package:flutter/material.dart';
import 'package:terremoto/ui/home.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String _title = 'Terremoto';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title ,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title:_title)
    );
  }
}
