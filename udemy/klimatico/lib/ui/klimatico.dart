import 'package:flutter/material.dart';
import 'package:klimatico/transacoes/buscar_clima.dart';
import 'package:klimatico/util/util.dart' as util;

import 'mudar_cidade.dart';

class Klimatico extends StatefulWidget {
  final String title;

  Klimatico({Key key, this.title}) : super(key: key);

  @override
  _KlimaticoState createState() => _KlimaticoState();
}

class _KlimaticoState extends State<Klimatico> {
  String _cidadeInserida;

  Future _abrirNovaTela(BuildContext context) async {
    Map resultado = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return MudarCidade();
    }));
    if (resultado != null && resultado.containsKey('cidade') && resultado['cidade'].isNotEmpty) {
      _cidadeInserida = resultado['cidade'];
    }else{
      _cidadeInserida = util.cidade ;
    }
    debugPrint(_cidadeInserida);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            onPressed: () => _abrirNovaTela(context),
            icon: Icon(Icons.menu),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/umbrella.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                    '${_cidadeInserida == null ? util.cidade : _cidadeInserida}',
                    style: styleCidade())
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/light-rain.png'),
          ),
          atualizarTemperaturaWidget(_cidadeInserida)
        ],
      ),
    );
  }

  Widget atualizarTemperaturaWidget(String cidade) {
    return FutureBuilder(
        future: buscarClima(util.apiKey, cidade == null ? util.apiKey : cidade),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map conteudo = snapshot.data;
            debugPrint(conteudo.toString());
            var temp = conteudo['main']['temp'].toString();
            var humidade = conteudo['main']['humidity'].toString();
            var min = conteudo['main']['temp_min'].toString();
            var max = conteudo['main']['temp_max'].toString();
            return Container(
              margin: const EdgeInsets.fromLTRB(30, 250, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '${temp}º',
                      style: tempStyle(),
                    ),
                    subtitle: ListTile(
                      title: Text(
                        'Humidade: ${humidade}\n'
                        'Min:${min}º\n'
                        'Max:${max}º\n',
                        style: extraTemp(),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            Container(
              child: Text('Falha!'),
            );
          }
        });
  }

  TextStyle extraTemp() {
    return TextStyle(
        color: Colors.white70, fontSize: 19, fontStyle: FontStyle.normal);
  }

  TextStyle styleCidade() {
    return TextStyle(
        color: Colors.white, fontSize: 22.9, fontStyle: FontStyle.italic);
  }

  TextStyle tempStyle() {
    return TextStyle(
        color: Colors.white,
        fontSize: 49.9,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500);
  }
}
