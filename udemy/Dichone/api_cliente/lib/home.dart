import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'  as http;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  int _counter = 0;
  List _dados = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Api.getComments().then(
       (result) => _dados = result
     );
  }  

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _showMessage(BuildContext build,String message){
    var alert  = AlertDialog(
      title: Text("Json"),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("ok"),
        )
      ],
    );
    showDialog(context: context,builder: (context) => alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _dados.length,
          padding: const EdgeInsets.all(14.5),
          itemBuilder: (BuildContext context,int posicao){
            return Column(
              children: <Widget>[
                Divider(height: 5.5,),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Text("${_dados[posicao]['email'][0]}"),
                  ),
                  onTap: () => _showMessage(context,_dados[posicao]['body']),
                  title: Text(
                    "${_dados[posicao]['email']}"
                  ),
                  subtitle: Text(
                    "${_dados[posicao]['body']}"
                  ),
                )
              ],
            );
          },

        )
      ),
    );
  }
}


class Api{

  static Future <List> getComments() async {
      String url = 'https://jsonplaceholder.typicode.com/comments';
      http.Response  response = await http.get(url);
      if( response.statusCode == 200 ){
        return json.decode(response.body);
      }else{
        throw Exception('Falhou');
      }
  }

  static Future <List> getUsers() async {
      String url = 'https://jsonplaceholder.typicode.com/users';
      http.Response  response = await http.get(url);
      if( response.statusCode == 200 ){
        return json.decode(response.body);
      }else{
        throw Exception('Falhou');
      }
  }

}