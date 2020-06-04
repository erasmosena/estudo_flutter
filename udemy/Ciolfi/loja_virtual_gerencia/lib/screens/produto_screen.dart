import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/produto_bloc.dart';
import 'package:loja_virtual_gerencia/validators/produto_validator.dart';
import 'package:loja_virtual_gerencia/widgets/images_widget.dart';
import 'package:loja_virtual_gerencia/widgets/produto_sizes.dart';

class ProdutoScreen extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot produto;

  ProdutoScreen({this.categoryId, this.produto});

  @override
  _ProdutoScreenState createState() => _ProdutoScreenState(categoryId, produto);
}

class _ProdutoScreenState extends State<ProdutoScreen> with ProdutoValidator {
  final ProdutoBloc _produtoBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _ProdutoScreenState(String categoryId, DocumentSnapshot produto)
      : _produtoBloc = ProdutoBloc(categoryId, produto);

  @override
  Widget build(BuildContext context) {
    final _fieldStyle = TextStyle(color: Colors.white, fontSize: 16);
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.grey));
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: StreamBuilder<bool>(
            stream: _produtoBloc.outCreated,
            builder: (context, snapshot) {
              return Text(snapshot.data ? "Editar Produto" : "Criar Produto");
            }),
        actions: <Widget>[
          StreamBuilder(
            stream: _produtoBloc.outCreated,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData)
                return StreamBuilder<bool>(
                    stream: _produtoBloc.outLoading,
                    initialData: false,
                    builder: (context, snapshot) {
                      return IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: snapshot.data
                            ? null
                            : () {
                                _produtoBloc.deleteProduto();
                                Navigator.of(context).pop();
                              },
                      );
                    });
              else
                return Container();
            },
          ),
          StreamBuilder<bool>(
              stream: _produtoBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                    icon: Icon(Icons.save),
                    onPressed: snapshot.data ? null : saveProduto);
              })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: true,
            child: StreamBuilder<Map>(
                stream: _produtoBloc.outData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: <Widget>[
                      Text("images",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ImagesWidget(
                        initialValue: snapshot.data["images"],
                        onSaved: (l) {},
                        validator: validateImages,
                        context: context,
                        onChanged: (lista) {
                          _produtoBloc.toUnsavedList("images", lista);
                          this.validateImages(lista);
                        },
                      ),
                      TextFormField(
                        initialValue: snapshot.data["title"],
                        style: _fieldStyle,
                        decoration: _buildDecoration("Titulo"),
                        onSaved: (t) {},
                        validator: validateTitle,
                        onChanged: (text) {
                          _produtoBloc.toUnsavedText("title", text);
                          this.validateTitle(text);
                        },
                      ),
                      TextFormField(
                        initialValue: snapshot.data["description"],
                        style: _fieldStyle,
                        maxLines: 6,
                        decoration: _buildDecoration("Descrição"),
                        onSaved: (t) {},
                        validator: validateDescription,
                        onChanged: (text) {
                          _produtoBloc.toUnsavedText("description", text);
                          this.validateDescription(text);
                        },
                      ),
                      TextFormField(
                        initialValue:
                            snapshot.data["price"]?.toStringAsFixed(2),
                        style: _fieldStyle,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: _buildDecoration("Preço"),
                        onSaved: (t) {},
                        validator: validatePrice,
                        onChanged: (text) {
                          _produtoBloc.toUnsavedNumber("price", text);
                          this.validatePrice(text);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text("Tamanhos",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ProdutoSizes(
                        context: context,
                        initialValue: snapshot.data["sizes"],
                        onSaved: (s) {},
                        validator: (s) {
                          if (s.isEmpty) return "";
                        },
                      )
                    ],
                  );
                }),
          ),
          StreamBuilder<bool>(
              stream: _produtoBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IgnorePointer(
                  ignoring: !snapshot.data,
                  child: Container(
                    color: snapshot.data ? Colors.black54 : Colors.transparent,
                  ),
                );
              })
        ],
      ),
    );
  }

  void saveProduto() async {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Salvando produto... ",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(minutes: 1),
        backgroundColor: Colors.pinkAccent,
      ));

      bool success = await _produtoBloc.saveProduto();
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          success ? "Produto salvo" : "Erro ao salvar produto",
          style: TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          label: "Fechar",
          textColor: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState.removeCurrentSnackBar();
          },
        ),
        duration: Duration(minutes: 1),
        backgroundColor: Colors.pinkAccent,
      ));
    }
  }
}
