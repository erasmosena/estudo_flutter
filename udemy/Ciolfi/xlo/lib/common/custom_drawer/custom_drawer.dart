import 'package:flutter/material.dart';
import 'package:xlo/common/custom_drawer/widget/custom_header.dart';
import 'package:xlo/common/custom_drawer/widget/menu.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(children: <Widget>[
      new Positioned(
        child: ListView(
          children: <Widget>[
            CustomHeader(),
            Menu(),
            Divider(
              color: Colors.grey[500],
            ),
          ],
        ),
      ),
      new Positioned(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      "powered by Senj"
                      ,textAlign: TextAlign.center,
                      ),
                  ),
                )
              ],
            )),
      )
    ]));
  }
}
