import 'package:flutter/material.dart';
import 'package:whats_clone/ui/home_abas.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("WhatsApp Clone"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => debugPrint("search"),
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => debugPrint("mais detalhes"),
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              IconButton(icon: Icon(Icons.photo_camera),onPressed:null),
              Tab(text:"CONVERSAS"),
              Tab(text:"STATUS"),
              Tab(text:"CHAMADAS"),
            ],
                
          ),
        ),
      body: HomeAbas(),
      )
    );
  }
}
