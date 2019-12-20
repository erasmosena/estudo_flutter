import 'package:flutter/material.dart';

void main() {
  runApp(Material(
      color: Colors.blueGrey,
      child: Center(
        child: Text("fsda",
            textDirection: TextDirection.ltr,
            style: new TextStyle(fontSize: 134, fontWeight: FontWeight.bold)),
      )));
}

class Bemvindo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
