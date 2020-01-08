import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    title: 'Minhas Tarefas',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _toDoController = TextEditingController();
  List _toDoList = [];
  Map<String,dynamic> _lastRemoved ;
  int _indexLastRemoved ; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readData().then((dados) {
      setState(() {
        _toDoList = json.decode(dados);
      });
    });
  }

  void _addList() {
    Map<String, dynamic> newToDo = Map();
    newToDo['title'] = _toDoController.text;
    newToDo['ok'] = false;
    setState(() {
      _toDoList.add(newToDo);
    });
    _toDoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                      controller: _toDoController,
                      decoration: InputDecoration(
                        labelText: "Nova tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent),
                      )),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: _addList,
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: _toDoList.length,
                itemBuilder: buildItem),
            )
          )
        ],
      ),
    );
  }
  
  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a , b){
        if( a["ok"] && !b["ok"] ) return 1;
        else if( !a["ok"] && b["ok"] ) return -1;
        else return 0;
      });  
      _saveData();
    });
    
  }

  Widget buildItem(_, int position) {
    var item = _toDoList[position];
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(Icons.delete),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(item["title"]),
        subtitle: Text(""),
        value: item["ok"],
        secondary: CircleAvatar(
          child: Icon(_toDoList[position]["ok"] ? Icons.check : Icons.error),
        ),
        onChanged: (value) {
          setState(() {
            item["ok"] = value;
            _saveData();
          });
        },
      ),
      onDismissed: (direction){
        setState(() {
          _lastRemoved = Map.from(item); 
          _indexLastRemoved = position;
          _toDoList.removeAt(position);  
          _saveData();
          final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" removida"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: (){
                setState(() {
                  _toDoList.insert(_indexLastRemoved, _lastRemoved);
                  _saveData();
                });
              },
            ),
            duration: Duration(seconds: 3),
          );
          Scaffold.of(context).removeCurrentSnackBar();   
          Scaffold.of(_).showSnackBar(snack);
        });
        
      },
    );
  }

  Future<File> _getFile() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path;
    return File("$path/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
