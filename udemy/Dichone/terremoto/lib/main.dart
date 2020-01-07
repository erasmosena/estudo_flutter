import 'package:flutter/material.dart';
import 'package:terremoto/ui/home.dart';
import 'package:intl/intl.dart';


void main() async { 
  Intl.defaultLocale = 'pt_BR';
  runApp(MyApp());
}

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
