import 'package:flutter/material.dart';
import 'package:io_app/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = "I/O";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: title),
    );
  }
}
