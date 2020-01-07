import 'package:atividades/models/atividade.dart';
import 'package:atividades/util/db.dart';
import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'atividade_view.dart';

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
              itemBuilder: (_, int posicao) {
                Atividade itemLista = _list[posicao];
                return Card(
                  color: Colors.white10,
                  child: ListTile(
                    title: AtividadeView(itemLista),
                    onLongPress: () =>
                        _atualizarAtividade(itemLista, posicao),
                    trailing: Listener(
                      key: Key(itemLista.nome),
                      child: Icon(
                        Icons.remove_circle, 
                        color: Colors.redAccent
                      ),
                      onPointerDown: (PointerEvent)=> _removeAtividade(itemLista.id,posicao),
                    ),
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

  void _showForm() {
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
                  icon: Icon(Icons.note_add)),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _handleText(_control.text);
            _control.clear();
            Navigator.pop(context);
          },
          child: Text("Salvar"),
        )
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }

  void _handleText(String text) async {
    _control.clear();
    Atividade item = Atividade(text, _dataFormatada());
    int idItemSalvo = await db.salvar(item);
    Atividade itemSalvo = await db.get(idItemSalvo);
    setState(() {
      _list.insert(0, itemSalvo);
    });
  }

  _getAll() async {
    List lista = await db.getAll();
    lista.forEach((item) {
      setState(() {
        _list.add(Atividade.map(item));
      });
    });
  }

  String _dataFormatada() {
    var agora = DateTime.now();
    initializeDateFormatting("pt_BR", null);
    var formatador = DateFormat.yMMMMd("pt_BR");
    String formatada = formatador.format(agora);
    return formatada;
  }

  _atualizarAtividade(Atividade atividade, int posicao) {
    var alert = AlertDialog(
      title: Text("Atualizar Atividade"),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _control,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "Atividade",
                  hintText: "nova descrição para atividade",
                  icon: Icon(Icons.update)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            Atividade item = Atividade.fromMap({
              'nome': _control.text,
              'data': _dataFormatada(),
              'id': atividade.id
            });
            _handleUpdate(posicao, atividade);
            await db.update(item);
            setState(() {
              _getAll();
            });
            Navigator.pop(context);
          },
          child: Text("Atualizar"),
        ),
        FlatButton(
          child: Text("Cancelar"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _handleUpdate(int posicao, Atividade atividade) {
    setState(() {
      _list.removeWhere((item) {
        return _list[posicao].nome == atividade.nome;
      });
    });
  }
  
  _removeAtividade(int id, int posicao) async {
    await db.delete(id);
    setState(() {
      _list.removeAt(posicao);
    });
  }

}
