import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _anim = "spin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: (){
            setState(() {
              if(  _anim == "spin")
                _anim = "spin reversed";  
              else
                _anim = "spin";  
            });
          },
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              child: FlareActor(
                'assets/spin.flr',
                animation: '$_anim',
              ),
            ),
          ),
        ));
  }
}
