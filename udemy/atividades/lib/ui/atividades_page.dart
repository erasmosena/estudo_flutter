import 'package:atividades/models/atividade.dart';
import 'package:atividades/util/db.dart';
import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
    super.initState();
    _getAll();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _list.length,
              itemBuilder: (_,int posicao){
                return Card(
                  color: Colors.white10,
                  child: ListTile(
                    title: _list[posicao],
                    onLongPress: () => debugPrint("long press"),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: ListTile(
          title: Icon(Icons.add),
        ),
        onPressed: _showForm,

      ),
    );
  }

  void _showForm(){
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _control,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Atividade',
                hintText: 'prova de vetores',
                icon: Icon(Icons.note_add)
              ),
            ),
          ),
          
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            _handlerText(_control.text);
            _control.clear();
            Navigator.pop(context);
          }, child:Text("Salvar"),
        )
      ],
    );
    showDialog(context: context,builder: (context)=> alert);
  }

  void _handlerText(String text )async {
    _control.clear();
    Atividade item = Atividade(text, _dataFormatada());
    int idItemSalvo = await db.salvar(item);
    Atividade itemSalvo = await db.get(idItemSalvo);
    setState(() {
      _list.insert(0, itemSalvo);
    });
  }

  _getAll()async{
    List lista  = await db.getAll();
    lista.forEach((item){
      setState(() {
        _list.add(Atividade.map(item));  
      });
    });
  }

  String _dataFormatada(){
    var agora = DateTime.now();
    initializeDateFormatting("pt_BR", null);
    var formatador = DateFormat.yMMMMd("pt_BR");
    String formatada  = formatador.format(agora);
    return formatada;
  }
}