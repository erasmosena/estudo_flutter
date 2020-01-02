import 'package:atividades/ui/home.dart';
import 'package:flutter/material.dart';


void main() => runApp(Atividades());


class Atividades extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Atividades",
      home: Home(),
      
    );
  }
}