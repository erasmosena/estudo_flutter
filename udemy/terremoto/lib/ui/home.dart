import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  var format = new DateFormat("ddMMyyyy",);
  @override
  void initState() {
    super.initState();
    
    API.getTerremotos().then(
      (dados){
        _dados= dados;
      }    
    );
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
          itemCount: _dados.features.length ,
          itemBuilder: (BuildContext context, int posicao){
            
            return Column (
              children: <Widget>[
                Divider(height: 5.5,),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Text("${_dados.features[posicao].properties.mag}"),
                  ),
                  title: Text("${format.format(DateTime.fromMillisecondsSinceEpoch(_dados.features[posicao].properties.time))}"),
                  subtitle: Text("${_dados.features[posicao].properties.place}"),
                  onTap: null,

                )
              ],
            );
          },

        ),
      )
    );
  }
}