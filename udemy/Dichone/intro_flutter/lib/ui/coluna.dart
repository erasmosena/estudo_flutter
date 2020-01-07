
import 'package:flutter/material.dart';

class Coluna extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return 
    Container( 
      color: Colors.blueAccent,
      child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text("Primeiro",
        
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontStyle: FontStyle.italic
          ,fontSize: 15
        ),
        ),
        //Expanded(child: Text("Olá"),),
        Flexible(child: Text("Outro"),),
        Text("Segundo",
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontStyle: FontStyle.italic
          ,fontSize: 15
        ),
        ),
        FlatButton(
          onPressed: () => "hello",
          color: Colors.white70,
          child: Text("Botão"),
        )
      ],
    )
    );
  }
}