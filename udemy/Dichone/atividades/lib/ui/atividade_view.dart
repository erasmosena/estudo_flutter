import 'package:flutter/material.dart';

import '../models/atividade.dart';

class AtividadeView extends StatelessWidget{
  AtividadeView(this.atividade);

  final Atividade atividade;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            atividade.nome,
            style:TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.9
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text(
              "Criado em ${atividade.dataRegistro}",
              style:TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                fontSize: 11.5
              )
            ),
          ),
        ],
      ),
    );
  }

}