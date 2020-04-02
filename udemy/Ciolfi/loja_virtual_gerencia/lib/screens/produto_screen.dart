import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/produto_bloc.dart';

class ProdutoScreen extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot produto;
  

  ProdutoScreen({this.categoryId, this.produto});
      

  @override
  _ProdutoScreenState createState() => _ProdutoScreenState(categoryId,produto);
}

class _ProdutoScreenState extends State<ProdutoScreen> {

  final ProdutoBloc _produtoBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

_ProdutoScreenState(String categoryId, DocumentSnapshot produto): _produtoBloc = ProdutoBloc(categoryId, produto);

  @override
  Widget build(BuildContext context) {
    final _fieldStyle = TextStyle(color: Colors.white,fontSize: 16);
    InputDecoration _buildDecoration(String label)  {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey)
      );
    }
    return Scaffold(
      
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text("Criar Produto"),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.remove),
            onPressed: (){},
          ),
          IconButton(
            icon:Icon(Icons.save),
            onPressed: (){}
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<Map>(
          stream: _produtoBloc.outData,
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Container();
            return ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  initialValue: snapshot.data["title"],
                  style: _fieldStyle,
                  decoration: _buildDecoration("Titulo"),
                  onSaved: (t){},
                  validator: (t){},
                ),
                TextFormField(
                  initialValue: snapshot.data["description"],
                  style: _fieldStyle,
                  maxLines: 6,
                  decoration: _buildDecoration("Descrição"),
                  onSaved: (t){},
                  validator: (t){},
                ),
                TextFormField(
                  initialValue: snapshot.data["price"]?.toStringAsFixed(2),
                  style: _fieldStyle,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: _buildDecoration("Preço"),
                  onSaved: (t){},
                  validator: (t){},
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
