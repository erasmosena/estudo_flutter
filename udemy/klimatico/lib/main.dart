import 'package:flutter/material.dart';
import 'package:klimatico/ui/klimatico.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  final String _title = 'Klimático';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title ,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Klimatico(title:_title)
    );
  }
}