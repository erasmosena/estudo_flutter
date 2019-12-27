import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("IMC"),
      ),
      body:Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(1.5),          
          children: <Widget>[
            Image.asset(
              "assets/imc-logo.png",
              width: 200,
              height: 147,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "O Seu Peso na Terra",
                        hintText: "Kg",
                        icon: Icon(Icons.person_outline)),
                  ),
                  TextField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "O Seu Peso na Terra",
                        hintText: "Kg",
                        icon: Icon(Icons.assessment ) ),
                  ),
                  TextField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "O Seu Peso na Terra",
                        hintText: "Kg",
                        icon: Icon(Icons.)),
                  )

                ],
              ),
            )
          ],
        ),
      )
    );
  }
}