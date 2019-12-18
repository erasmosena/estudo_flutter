
import 'dart:convert';


import 'package:carga_produto/models/produto.dart';
import 'package:carga_produto/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProdutosList extends StatefulWidget {
  @override
  createState() => _ProdutosListState();
}

class _ProdutosListState extends State<ProdutosList> {
  var produtos = new List<Produto>();

  @override
  void initState() {
    super.initState();
    _getProdutos();
  }

  dispose() {
    super.dispose();
  }
  _navigateToProduto(int id){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Detalhe do Produto'),
            ),
            //body:,
          );
        },
      ),
    );
  }

  _getProdutos() {
    API.getProdutos().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        produtos = list.map((model) => Produto.fromJson(model)).toList();
      });
    });
  }

   @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Produtos"),
        ),
        body: ListView.builder(
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(produtos[index].descricao),
              onTap: _navigateToProduto(produtos[index].id),
              );
          },
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: _getProdutos,
        tooltip: 'Carregar Produtos',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      );
  }
}
