import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scaffold"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.accessible),
            onPressed: () => debugPrint("Ola"),
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => debugPrint("Ei"),
          ),
          IconButton(
            icon: Icon(Icons.timer),
            onPressed: () => debugPrint("Time"),
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bonni",
              style: TextStyle(
                  fontSize: 19.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: InkWell(
                child: Text(
                  "Clique",
                  style: TextStyle(fontSize: 16.0),
                ),
                onTap: () => debugPrint("Tap"),
                onDoubleTap: () => debugPrint("Double Tap"),
                onLongPress: () => debugPrint("Long press"),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            title: Text("Perfil")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.print),
            title: Text("")
          )
        ],
      ),
    );
  }
}
