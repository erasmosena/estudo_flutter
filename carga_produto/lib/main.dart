import 'package:carga_produto/views/home/home.dart';
import 'package:carga_produto/views/produto/produtos_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Carga de Produtos X2'),
      home: Home()
    );
  }
}

