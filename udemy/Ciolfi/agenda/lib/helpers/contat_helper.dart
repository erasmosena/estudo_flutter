import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String contactTable = "tb_contato";
final String idColumn = "id_contato";
final String nameColumn = "ds_name";
final String emailColumn = "ds_email";
final String phoneColumn = "ds_phone";
final String imgColumn = "ds_img";
final List<String> columns = [ 
  idColumn,
  nameColumn,
  emailColumn,
  phoneColumn,
  imgColumn
];

class ContactHelper{
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;
  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if( _db != null ){
      return _db;
    }else{
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contact.db");
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }
  _onCreate(Database db, int newerVersion) async {
    await db.execute("""
      CREATE TABLE $contactTable (
        $idColumn     INTEGER PRIMARY KEY,
        $nameColumn   TEXT,
        $emailColumn  TEXT,
        $phoneColumn  TEXT,
        $imgColumn    TEXT
      );
    """);
  }

  Future<Contact> save(Contact contact)async{
    Database dbContact = await db;
    contact._id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact>getSingle(int id)async{
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(
      contactTable, 
      columns: columns,
      where: "$idColumn = ?",
      whereArgs: [id]);
    if( maps.length > 0 )
      return Contact.fromMap(maps.first);
    else 
      return null;
  }
  Future<int>  delte(int id )async{
    Database dbContact = await db;
    return await dbContact.delete(contactTable, where:"$idColumn = ?", whereArgs: [id]);
  }

  Future<int> update(Contact contact)async{
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),  where:"$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List<Contact>> getAll()async{
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery(" select * from $contactTable");
    List<Contact> listContact = List();
    for(Map m in listMap){
      listContact.add(Contact.fromMap(m)); 
    }
    return listContact;
  }

  Future<int> getCount()async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
      await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable")
    );
  }

  Future close()async{
    Database dbContact = await db;
    dbContact.close();
  }


}

class Contact {
  int     _id;
  String  _name;
  String  _email; 
  String  _phone;
  String  _img;

  int     get id => _id;
  String  get name => _name;
  String  get email => _email;
  String  get phone => _phone;
  String  get img => _img;

  set id (value){ _id = value;}
  set name (value){ _name = value;}
  set email (value){ _email = value;}
  set phone (value){ _phone = value;}
  set img (value){ _img = value;}

  Contact();

  Contact.map(dynamic obj){
    this._id =  obj[idColumn];
    this._name =  obj[nameColumn];
    this._email =  obj[emailColumn];
    this._phone =  obj[phoneColumn];
    this._img =  obj[imgColumn];
  }
    

  Contact.fromMap(Map map){
    _id    = map[idColumn];
    _name  = map[nameColumn];
    _email = map[emailColumn];
    _phone = map[phoneColumn];
    _img   = map[imgColumn];
  }

  Map toMap(){
    Map<String,dynamic> map ={
      nameColumn  : _name, 
      emailColumn : _email, 
      phoneColumn : _phone, 
      imgColumn   : _img
    };

    if( id != null ){
      map[idColumn] = _id;
    }

    return map;

  }
  @override
  String toString() {
    return "Contato: ${toMap()}";
  }

}