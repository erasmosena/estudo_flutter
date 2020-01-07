import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _dinheiro = 100;

  void maisGrana() {
    setState(() {
      _dinheiro += 100;
    });
  }

  void menosGrana() {
    setState(() {
      _dinheiro -= 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Text(
                "Fique rico !",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 29.9),
              ),
            ),
            Expanded(
                child: Center(
              child: Text(
                "\$ $_dinheiro",
                style: TextStyle(
                    color: _dinheiro > 0
                        ? Colors.lightGreen
                        : _dinheiro < 0 ? Colors.redAccent : Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 45.6),
              ),
            )),
            Expanded(
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      RaisedButton(
                        onPressed: () => maisGrana(),
                        color: Colors.lightGreen,
                        textColor: Colors.white70,
                        child: Text(
                          "Mais grana!",
                          style: TextStyle(fontSize: 19.9),
                        ),
                      ),
                      RaisedButton(
                onPressed: () => menosGrana(),
                color: Colors.redAccent,
                textColor: Colors.white70,
                child: Text(
                  "Menos grana!",
                  style: TextStyle(fontSize: 19.9),
                ),
              ),
                  ]
            ))),
          ],
        ),
      ),
    );
  }
}
