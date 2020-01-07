import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _campoDadosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: Container(
            alignment: Alignment.topCenter,
            child: Column(children: <Widget>[
              TextField(
                controller: _campoDadosController,
                decoration: InputDecoration(
                  labelText: 'Escreva algo',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(14.9),
              ),
              FlatButton(
                color: Colors.greenAccent,
                onPressed: () {
                  gravarDados(_campoDadosController.text);
                },
                child: Column(
                  //;mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Gravar'),
                  ],
                )
              ),
              FutureBuilder(
                future: lerDados(),
                builder: (BuildContext context, AsyncSnapshot<String> dados) {
                  if (dados.hasData) {
                    return Text(
                      dados.data,
                      style: TextStyle(color: Colors.black),
                    );
                  }else{
                    return Text("Nada foi Salvo ainda.");
                  }
                },
              )
            ])));
  }
}

Future<String> get _caminhoLocal async {
  final diretorio = await getApplicationDocumentsDirectory();
  return diretorio.path;
}

Future<File> get _arquivoLocal async {
  final caminho = await _caminhoLocal;
  return File("$caminho/dados.txt");
}

Future<File> gravarDados(String mensagem) async {
  final arquivo = await _arquivoLocal;
  return arquivo.writeAsString(mensagem);
}

Future<String> lerDados() async {
  try {
    final arquivo = await _arquivoLocal;
    return await arquivo.readAsString();
  } catch (erro) {
    return "erro ao ler o arquivo : \n $erro";
  }
}
