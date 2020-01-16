import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String categoriaTable = "tb_categoria";
final String idColumn = "id_categoria";
final String nameColumn = "ds_categoria";
final String imgColumn = "ds_img";
final List<String> columns = [idColumn, nameColumn, imgColumn];

class CategoriaHelper {
  static final CategoriaHelper _instance = CategoriaHelper.internal();
  factory CategoriaHelper() => _instance;
  CategoriaHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "categoria.db");
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int newerVersion) async {
    await db.execute("""
      CREATE TABLE $categoriaTable (
        $idColumn     INTEGER PRIMARY KEY,
        $nameColumn   TEXT,
        $imgColumn    TEXT
      );
    """);
  }

  Future<Categoria> save(Categoria categoria) async {
    Database dbContact = await db;
    categoria._id = await dbContact.insert(categoriaTable, categoria.toMap());
    return categoria;
  }

  Future<Categoria> getSingle(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(categoriaTable,
        columns: columns, where: "$idColumn = ?", whereArgs: [id]);
    if (maps.length > 0)
      return Categoria.fromMap(maps.first);
    else
      return null;
  }

  Future<int> delte(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(categoriaTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> update(Categoria categoria) async {
    Database dbContact = await db;
    return await dbContact.update(categoriaTable, categoria.toMap(),
        where: "$idColumn = ?", whereArgs: [categoria.id]);
  }

  Future<List<Categoria>> getAll() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery(" select * from $categoriaTable");
    List<Categoria> listContact = List();
    for (Map m in listMap) {
      listContact.add(Categoria.fromMap(m));
    }
    return listContact;
  }

  Future<int> getCount() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $categoriaTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}

class Categoria {
  final String idColumn = "id_categoria";
  final String nameColumn = "ds_categoria";
  final String imgColumn = "ds_img";
  int _id;
  String _dsCategoria;
  String _img;

  int get id => _id;
  String get name => _dsCategoria;
  String get img => _img;

  set id(value) {
    _id = value;
  }

  set name(value) {
    _dsCategoria = value;
  }

  set img(value) {
    _img = value;
  }

  Categoria();

  Categoria.map(dynamic obj) {
    this._id = obj[idColumn];
    this._dsCategoria = obj[nameColumn];
    this._img = obj[imgColumn];
  }

  Categoria.fromMap(Map map) {
    _id = map[idColumn];
    _dsCategoria = map[nameColumn];
    _img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {nameColumn: _dsCategoria, imgColumn: _img};

    if (id != null) {
      map[idColumn] = _id;
    }

    return map;
  }

  @override
  String toString() {
    return "Categoria: ${toMap()}";
  }
}
