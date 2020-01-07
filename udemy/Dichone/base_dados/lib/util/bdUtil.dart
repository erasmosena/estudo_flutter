import 'dart:io';
import 'package:base_dados/models/usuario.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseSingleton{
  static final DataBaseSingleton _instance = DataBaseSingleton.internal();
  factory DataBaseSingleton()=> _instance;
  DataBaseSingleton.internal();

  static Database _db ; 

  Future<Database> get db async {
    if( _db != null ) return _db;
    _db = await initdb();
    return db;
  }

  initdb()async{
    Directory documentPath = await getApplicationDocumentsDirectory();
    String path = join(
      documentPath.path,"db_principal.db"
    );
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;

  }

  void _onCreate(Database db , int version)async {
    String sql =
    "CREATE TABLE tb_usuario( "
    " id integer PRIMARY KEY , "
    " nome varchar(200) not null , "
    " senha varchar(100) not null "
    " ); "
    ;
    await db.execute(sql);
  }


  Future<int> inserirUsuario(Usuario usuario)async{
    var dbClient = await db;
    int res = await dbClient.insert("tb_usuario",usuario.toMap());
    return res;
  }

  Future<List> getUsuarios(Usuario usuario)async{
    var dbClient = await db;
    var res = await dbClient.rawQuery(" select * from tb_usuario ");
    return res.toList();
  }

  Future<int> countUsuarios()async{
    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("select count(*) from tb_usuario ")
    );
  }

  Future<Usuario> getUsuario(int id )async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("select * from tb_usuario where id = $id");
    if (res.length == 0 ) return null ;
    return Usuario.fromMap(res.first);
  }

  Future<int> deleteUsuario(int id )async{
    var dbClient = await db;
    return await dbClient.delete("tb_usuario",where:"id = ?", whereArgs: [id]);
    
  }


  Future<int> atualizarUsuario( Usuario usuario) async {
    var dbClient = await db;
    return await dbClient.update("tb_usuario", usuario.toMap(), where:"id = ?", whereArgs: [usuario.id] );

  }

  Future fechar()async{
    var dbClient = await db;
    return dbClient.close();
  }

}