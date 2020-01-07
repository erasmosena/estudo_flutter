import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:terremoto/services/api.dart';

import '../models/terremoto.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Terremoto _dados = Terremoto() ;
  
  @override
  void initState() {
    super.initState();
    
    API.getTerremotos().then(
      (dados){
        _dados= dados;
      }    
    );
  }

  void _exibirDetalhe(BuildContext context, String conteudo){
    var alert = AlertDialog(
      title: Text("Terremotos"),
      content: Text(conteudo),
      actions: <Widget>[
        FlatButton(
          child: Text("Voltar"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(context: context,builder: (context)=> alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(14.5),
          itemCount: _dados?.features?.length ,
          itemBuilder: (BuildContext context, int posicao){
            initializeDateFormatting("pt_BR",null);
            int mlsec = _dados.features[posicao].properties.time ;
            var format = new DateFormat.yMMMMd("pt_BR").add_jm();
            String data = format.format(DateTime.fromMillisecondsSinceEpoch(mlsec));
            return Column (
              children: <Widget>[
                Divider(height: 5.5,),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Text("${_dados.features[posicao].properties.mag}"),
                  ),
                  title: Text("${data}"),
                  subtitle: Text("${_dados.features[posicao].properties.place}"),
                  onTap: ()=> _exibirDetalhe(context,"M ${_dados.features[posicao].properties.mag} - ${_dados.features[posicao].properties.place}"),

                )
              ],
            );
          },

        ),
      )
    );
  }
}