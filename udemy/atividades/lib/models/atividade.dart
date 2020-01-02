import 'package:flutter/material.dart';


class Atividade extends StatelessWidget {
  String _nome;
  String _dataRegistro;
  int _id;

  Atividade(this._nome, this._dataRegistro);

  Atividade.map(dynamic obj){
    this._nome = obj['nome'];
    this._dataRegistro = obj['dataRegistro'];
    this._id = obj['id'];
  }

  String get nome => _nome;
  String get dataRegistro => _dataRegistro;
  int get id => _id;

  Map<String,dynamic> toMap(){
    var mapa = Map<String,dynamic>();
    mapa["nome"] = _nome;
    mapa["dataRegistro"] = _dataRegistro;
    if(_id != null ) mapa["id"] = _id;
    return mapa;
  }

  Atividade.fromMap(Map<String,dynamic> mapa){
    this._nome = mapa["nome"];
    this._dataRegistro = mapa["dataRegistro"];
    this._id = mapa["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _nome,
            style:TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.9
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text(
              "Criado em $_dataRegistro",
              style:TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                fontSize: 12.5
              )
            ),
          ),
        ],
      ),
    );
  }
}