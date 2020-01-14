import 'package:flutter/material.dart';
import 'package:lojavirtual/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController ;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32, top: 16),
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        "Loja \nVirtual",
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Olá,",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Text(
                                "Entre ou cadastre-se",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )),
                    
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home,"Inicio",pageController,0),
              DrawerTile(Icons.list,"Produtos",pageController,1),
              DrawerTile(Icons.location_on, "Encontre uma loja",pageController,2),
              DrawerTile(Icons.playlist_add_check,"Pedidos",pageController,3)
            ],
          )
        ],
      ),
    );
  }
}
