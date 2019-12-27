import 'package:flutter/material.dart';
import 'package:whats_clone/ui/chamadas_list.dart';
import 'package:whats_clone/ui/conversas_list.dart';
import 'package:whats_clone/ui/status_list.dart';



class HomeAbas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TabBarView(
      children: <Widget>[
        ConversasList(),
        ConversasList(),
        StatusList(),
        ChamadasList()
      ],
    );
  }
}
