import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Eventos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventos"),
      ),
      body: Center(
        child: MeuBotao(),
      ),
    );
  }
}

class MeuBotao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(content: Text("olá"));
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color:Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.5)
        ),
        child: Text("O meu botão"),
      ),
    );
  }
}
