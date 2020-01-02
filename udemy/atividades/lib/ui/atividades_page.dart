import 'package:atividades/models/atividade.dart';
import 'package:atividades/util/db.dart';
import 'package:flutter/material.dart';

class AtividadesPage extends StatefulWidget {
  @override
  _AtividadesPageState createState() => _AtividadesPageState();
}

class _AtividadesPageState extends State<AtividadesPage> {
  final TextEditingController _control = TextEditingController();
  var db = DaoAtividade();
  final List<Atividade> _list = List<Atividade>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAll();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Text("Fanfa!")
        ],
      ),
    );
  }

  _getAll()async{
    List lista  = await db.getAll();
  }
}