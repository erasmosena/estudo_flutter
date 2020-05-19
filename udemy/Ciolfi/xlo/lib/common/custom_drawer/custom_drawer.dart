import 'package:flutter/material.dart';
import 'package:xlo/common/custom_drawer/widget/custom_header.dart';
import 'package:xlo/common/custom_drawer/widget/menu.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          CustomHeader(),
          Menu(),
          Divider(color: Colors.grey[500],)
        ],
      ),
    );
  }
}