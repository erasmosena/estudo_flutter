import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/atividade.dart';

class DaoAtividade{
  static final DaoAtividade _instance = new DaoAtividade.internal();
  factory DaoAtividade() => _instance;
  static Database _db;

  Future<Database> get db async{
    if( _db != null ) return _db;
    _db = await initDb();
    return _db;
  }

  DaoAtividade.internal();

  initDb()async{
    Directory documentPath = await getApplicationDocumentsDirectory();
    String path = join(documentPath.path, "atividade.db");
    var newDb = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate);
      return newDb;
  }

  void _onCreate(Database db , int version)async {
    await db.execute("""
      CREATE TABLE tb_atividade(
        id integer PRIMARY KEY,
        nome varchar(200),
        data varchar(50)
      );
    """);
    debugPrint("tabela criada");
  }

  Future<int> salvar(Atividade item)async {
    var dbClient = await db;
    int res = await dbClient.insert("tb_atividade",item.toMap());
    print(res.toString());
    return res;
  }

  Future<List> getAll()async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("""
      select * 
      from tb_atividade 
      order by nome asc 
    """);
    return res.toList();
  }

  Future<int> count()async{
    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("""
        select count(*) from tb_atividade
      """)
    );
  }

  Future<Atividade> get(int id)async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("""
      select * from tb_atividade where id = $id
    """);
    if( res.length == 0 ) return null ;
    return Atividade.fromMap(res.first);
  }

  Future<int> delete(int id)async {
    var dbClient = await db;
    return await dbClient.delete("tb_atividade",where: " id = ?", whereArgs: [id]);
  }

  Future<int> update(Atividade item)async{
    var dbClient = await db;
    return await dbClient.update("tb_atividade", item.toMap(), where: " id = ?", whereArgs: [item.id]);
  }


}