import 'package:flutter/material.dart';


class Atividade  {
  String _nome;
  String _dataRegistro;
  int _id;

  Atividade(this._nome, this._dataRegistro);

  Atividade.map(dynamic obj){
    this._nome = obj['nome'];
    this._dataRegistro = obj['data'];
    this._id = obj['id'];
  }

  String get nome => _nome;
  String get dataRegistro => _dataRegistro;
  int get id => _id;

  Map<String,dynamic> toMap(){
    var mapa = Map<String,dynamic>();
    mapa["nome"] = _nome;
    mapa["data"] = _dataRegistro;
    if(_id != null ) mapa["id"] = _id;
    return mapa;
  }

  Atividade.fromMap(Map<String,dynamic> mapa){
    this._nome = mapa["nome"];
    this._dataRegistro = mapa["data"];
    this._id = mapa["id"];
  }

}