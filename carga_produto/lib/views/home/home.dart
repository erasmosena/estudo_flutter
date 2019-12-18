
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {

   @override
  build(context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(""),
        // ),
        body: Text("Produtos")
        // This trailing comma makes auto-formatting nicer for build methods.
      );
  }
}
