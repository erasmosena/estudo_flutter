

import 'package:carga_produto/models/produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProdutoPage extends StatefulWidget {
  ProdutoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}



class _ProdutoPageState extends State<ProdutoPage> {
  Future _data;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<Produto>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.descricao);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: initState,
        tooltip: 'Carregar Produtos',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}